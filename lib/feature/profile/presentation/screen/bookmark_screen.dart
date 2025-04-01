import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewith/feature/profile/presentation/controller/bookmark_controller.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/data/member/response/bookmark_response.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<BookmarkResponse> bookmarks = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeTabController();
    });
  }

  void _initializeTabController() {
    final response = ref.read(fetchBookmarksProvider);
    response.whenData((data) {
      data.match(
        onSuccess: (bookmarkList) {
          if (!mounted) return;
          setState(() {
            bookmarks = bookmarkList.bookmarks;
            _tabController?.dispose();
            if (bookmarks.isNotEmpty) {
              _tabController = TabController(length: bookmarks.length, vsync: this);
            }
          });
        },
        onFailure: (_) {},
      );
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(fetchBookmarksProvider, (previous, next) {
      next.whenData((data) {
        data.match(
          onSuccess: (bookmarkList) {
            if (!mounted) return;
            setState(() {
              bookmarks = bookmarkList.bookmarks;
              _tabController?.dispose();
              if (bookmarks.isNotEmpty) {
                _tabController = TabController(length: bookmarks.length, vsync: this);
              } else {
                _tabController = null;
              }
            });
          },
          onFailure: (_) {},
        );
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('즐겨찾기 한 좌석 후기', style: AppDesign.typo.title2bold()),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              '편집',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: ref.watch(fetchBookmarksProvider).when(
            data: (data) => data.match(
              onSuccess: (_) {
                if (bookmarks.isEmpty || _tabController == null) {
                  return const Center(
                    child: Text('즐겨찾기한 좌석이 없습니다.'),
                  );
                }

                return DefaultTabController(
                  length: bookmarks.length,
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        tabs: bookmarks.map((venue) => Tab(text: venue.venueName)).toList(),
                        labelStyle: AppDesign.typo.body4Bold(),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: bookmarks.map((venue) => _buildVenuePage(venue)).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
              onFailure: (error) => Center(child: Text('Error: $error')),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
    );
  }

  Widget _buildVenuePage(BookmarkResponse venue) {
    if (venue.bookmarkFloors.isEmpty) {
      return const Center(
        child: Text('즐겨찾기한 좌석이 없습니다.'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: venue.bookmarkFloors.map((floor) {
          return ExpansionTile(
            title: Text('${floor.bookmarkFloor}층'),
            children: floor.bookmarkSeats.map((seat) {
              return ListTile(
                title: Text(
                  '${seat.bookmarkSection ?? ''} ${seat.bookmarkRow != null ? '${seat.bookmarkRow}열' : ''}'.trim(),
                ),
                subtitle: Text(
                  seat.lastUpdateDate != null ? '마지막 업데이트: ${seat.lastUpdateDate!.toString()}' : '',
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
