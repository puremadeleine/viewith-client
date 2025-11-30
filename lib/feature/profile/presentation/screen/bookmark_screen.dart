import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/profile/presentation/controller/bookmark_controller.dart';
import 'package:viewith/feature/profile/presentation/screen/bookmarked_seat_reviews_screen.dart';
import 'package:viewith/data/venue/venue_repository_providers.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/error_widget.dart' as error_widget;
import 'package:viewith/data/member/response/bookmark_response.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<BookmarkResponse> bookmarks = [];
  bool _isEditMode = false;
  final Set<int> _selectedBookmarkIds = {};

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
            // API에서 받아온 데이터를 상태에 반영
            bookmarks = bookmarkList;
            _tabController?.dispose();
            if (bookmarkList.isNotEmpty) {
              _tabController = TabController(length: bookmarkList.length, vsync: this);
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
              // 새 데이터를 반영
              bookmarks = bookmarkList;
              _tabController?.dispose();
              if (bookmarkList.isNotEmpty) {
                _tabController = TabController(length: bookmarkList.length, vsync: this);
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
      backgroundColor: AppDesign.colors.gray50,
      appBar: AppBar(
        title: Text('즐겨찾기 한 좌석 후기', style: AppDesign.typo.title2bold()),
        actions: [
          if (!_isEditMode)
            TextButton(
              onPressed: () {
                setState(() {
                  _isEditMode = true;
                  _selectedBookmarkIds.clear();
                });
              },
              child: const Text(
                '편집',
                style: TextStyle(color: Colors.black),
              ),
            )
          else ...[
            TextButton(
              onPressed: () {
                // 편집 모드 취소
                setState(() {
                  _isEditMode = false;
                  _selectedBookmarkIds.clear();
                });
              },
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 8),
            Builder(
              builder: (context) {
                final hasSelection = _selectedBookmarkIds.isNotEmpty;
                return TextButton(
                  onPressed: hasSelection
                      ? () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('전체 삭제'),
                                content: const Text('선택한 좌석 즐겨찾기를 모두 삭제할까요?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('취소'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('삭제'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirmed == true) {
                            // 선택된 bookmarkId(= seat_id)를 서버에 즐겨찾기 해제 요청
                            final repository = ref.read(venueRepositoryProvider);
                            bool hasError = false;

                            for (final bookmarkId in _selectedBookmarkIds) {
                              bool found = false;

                              for (final venue in bookmarks) {
                                for (final floor in venue.bookmarkFloors) {
                                  for (final seat in floor.bookmarkSeats) {
                                    if (seat.bookmarkId == bookmarkId) {
                                      found = true;
                                      final result = await repository.deleteSeatBookmark(
                                        venueId: venue.venueId,
                                        seatId: seat.bookmarkId,
                                      );
                                      result.match(
                                        onSuccess: (_) {},
                                        onFailure: (error) {
                                          hasError = true;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('삭제 실패: ${error.message}')),
                                          );
                                        },
                                      );
                                      break;
                                    }
                                  }
                                  if (found) break;
                                }
                                if (found) break;
                              }
                            }

                            if (!hasError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('선택한 좌석 즐겨찾기가 삭제되었습니다.')),
                              );
                            }

                            // 서버 상태 최신화
                            ref.invalidate(fetchBookmarksProvider);

                            setState(() {
                              _isEditMode = false;
                              _selectedBookmarkIds.clear();
                            });
                          }
                        }
                      : null,
                  child: Text(
                    '전체 삭제',
                    style: TextStyle(
                      color: hasSelection ? Colors.red : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ],
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
                      // 탭바 영역은 흰색 배경, 탭 선택 시 pressed 효과 제거
                      Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                        child: Container(
                          color: AppDesign.colors.white,
                          child: TabBar(
                            controller: _tabController,
                            tabs: bookmarks.map((venue) => Tab(text: venue.venueName)).toList(),
                            labelStyle: AppDesign.typo.body4Bold(),
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                        ),
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
              onFailure: (error) => error_widget.ErrorWidget(
                error: error,
                onRetry: () => ref.invalidate(fetchBookmarksProvider),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (err, stack) => error_widget.ErrorWidget(
              error: error_widget.mapExceptionToError(err),
              onRetry: () => ref.invalidate(fetchBookmarksProvider),
            ),
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
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppDesign.colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppDesign.colors.gray200,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: AppDesign.colors.gray200,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: ExpansionTile(
                  collapsedBackgroundColor: AppDesign.colors.white,
                  backgroundColor: AppDesign.colors.white,
                  title: Text(
                    '${floor.bookmarkFloor}층',
                    style: AppDesign.typo.body1SemiBold(),
                  ),
                  children: floor.bookmarkSeats.map((seat) {
              final isSelected = _selectedBookmarkIds.contains(seat.bookmarkId);
              return ListTile(
                leading: _isEditMode
                    ? Transform.scale(
                        scale: 1.2, // 서클 전체 크기 키움
                        child: Checkbox(
                          value: isSelected,
                          shape: const CircleBorder(),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                _selectedBookmarkIds.add(seat.bookmarkId);
                              } else {
                                _selectedBookmarkIds.remove(seat.bookmarkId);
                              }
                            });
                          },
                        ),
                      )
                    : null,
                title: Text(
                  '${seat.bookmarkSection ?? ''}구역 ${seat.bookmarkRow != null ? '${seat.bookmarkRow}열' : ''}'.trim(),
                  style: AppDesign.typo.body1(),
                ),
                subtitle: seat.lastUpdateDate != null
                    ? Text('마지막 업데이트: ${_formatDate(seat.lastUpdateDate!)}')
                    : null,
                onTap: () {
                  if (_isEditMode) {
                    // 편집 모드에서는 체크박스 토글만 수행
                    setState(() {
                      if (isSelected) {
                        _selectedBookmarkIds.remove(seat.bookmarkId);
                      } else {
                        _selectedBookmarkIds.add(seat.bookmarkId);
                      }
                    });
                  } else {
                    // 일반 모드에서는 해당 좌석 후기 리스트로 이동
                    final args = BookmarkedSeatReviewsArgs(
                      venueId: venue.venueId,
                      venueName: venue.venueName,
                      floor: floor.bookmarkFloor,
                      section: seat.bookmarkSection,
                      row: seat.bookmarkRow,
                    );
                    context.push(
                      AppRoute.bookmarkedSeatReviews.path,
                      extra: args,
                    );
                  }
                },
              );
            }).toList(),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _formatDate(int epochMillis) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(epochMillis);
    return DateFormat('yyyy년 MM월 dd일').format(dateTime);
  }
}
