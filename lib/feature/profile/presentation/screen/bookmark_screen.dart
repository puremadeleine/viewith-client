import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewith/data/member/member_repository_providers.dart';
import 'package:viewith/feature/profile/presentation/controller/bookmark_controller.dart';
import 'package:viewith/ui/app_design.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final response = ref.watch(fetchBookmarksProvider);
    return response.when(
      data: (data) => _buildBody(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildBody() {
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '고척 스카이돔'),
            Tab(text: '장충 체육관'),
            Tab(text: '잠실 실내체육관'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStadiumPage(title: '고척 스카이돔'),
          _buildStadiumPage(title: '장충 체육관'),
          _buildStadiumPage(title: '잠실 실내체육관'),
        ],
      ),
    );
  }

  Widget _buildStadiumPage({required String title}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            title: const Text('3구역'),
            children: [
              ListTile(
                title: Text('3구역 좌석 후기 1'),
                subtitle: Text(title),
              ),
              ListTile(
                title: Text('3구역 좌석 후기 2'),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('5구역'),
            children: const [
              ListTile(
                title: Text('5구역 좌석 후기 1'),
              ),
              ListTile(
                title: Text('5구역 좌석 후기 2'),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('7구역'),
            children: const [
              ListTile(
                title: Text('7구역 좌석 후기 1'),
              ),
              ListTile(
                title: Text('7구역 좌석 후기 2'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
