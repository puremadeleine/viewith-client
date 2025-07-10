import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/home/presentation/controller/home_controller.dart';
import 'package:viewith/feature/home/presentation/widget/venue_item.dart';
import 'package:viewith/feature/profile/presentation/controller/profile_controller.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/di/app_providers.dart';

import '../../../../data/venue/response/venue.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);
    final isGuestMode = ref.watch(isGuestModeProvider);
    final member = ref.watch(fetchProfileProvider).asData?.value.successValue;

    final nickname = isGuestMode ? '비회원' : member?.nickname ?? '';

    return Scaffold(
      backgroundColor: AppDesign.colors.white,
      appBar: AppBar(
        title: Text('VIEWITH', style: AppDesign.typo.title1ExtraBold()),
        centerTitle: false,
        elevation: 0,
      ),
      body: state.when(
        data: (venues) => _buildBody(venues, nickname),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            'Error: $err',
            style: AppDesign.typo.body1(color: AppDesign.colors.gray500),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(List<Venue> venues, String nickname) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppDesign.spacing.horizontal24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle('$nickname님!'),
                AppDesign.spacing.h4,
                _buildSubtitle('시야를 확인해 보세요.'),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelStyle: AppDesign.typo.title1(color: AppDesign.colors.gray900),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              tabs: const [
                Tab(text: '🎙️'),
                Tab(text: '⚾️'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: venues.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          AppRoute.seatmap.name,
                          pathParameters: {'id': venues[index].id.toString()},
                          extra: {'name': venues[index].name},
                        );
                      },
                      child: VenueItem(venue: venues[index]),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfileAvatar(),
                    const SizedBox(height: 16),
                    Text('준비 중인 기능입니다.\n조금만 기다려주세요!', style: AppDesign.typo.title2semiBold(color: AppDesign.colors.gray900)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage('assets/images/rabbit_profile.png'),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: AppDesign.typo.title1ExtraBold(color: AppDesign.colors.gray900),
    );
  }

  Widget _buildSubtitle(String subtitle) {
    return Text(
      subtitle,
      style: AppDesign.typo.title2semiBold(color: AppDesign.colors.gray900),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: AppDesign.colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppDesign.colors.gray200,
          width: 1,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: '공연장 또는 아티스트 검색',
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
