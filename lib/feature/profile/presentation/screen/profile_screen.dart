import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/data/auth/auth_repository_providers.dart';
import 'package:viewith/data/member/response/profile_response.dart';
import 'package:viewith/di/app_providers.dart';
import 'package:viewith/feature/profile/presentation/controller/profile_controller.dart';
import 'package:viewith/feature/profile/presentation/model/profile_enum.dart';
import 'package:viewith/ui/app_design.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isGuestMode = ref.watch(isGuestModeProvider);

    return Scaffold(
      appBar: _buildAppBar(),
      body: isGuestMode ? _buildGuestModeBody() : _buildMainContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Center(
        child: Text(
          '내 프로필',
          style: AppDesign.typo.title2bold(color: AppDesign.colors.gray900),
        ),
      ),
    );
  }

  Widget _buildGuestModeBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '로그인이 필요한 서비스입니다.',
            style: AppDesign.typo.title2semiBold(color: AppDesign.colors.gray900),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppDesign.colors.gray900,
              foregroundColor: AppDesign.colors.white,
            ),
            onPressed: () {
              ref.read(isGuestModeProvider.notifier).state = false;
              context.go(AppRoute.signIn.path);
            },
            child: const Text('로그인 하러 가기'),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return ref.watch(fetchProfileProvider).when(
          data: (data) => data.match(
            onSuccess: (profile) => _buildBody(profile),
            onFailure: (error) => Center(child: Text('Error: $error')),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        );
  }

  Widget _buildBody(ProfileResponse data) {
    return Container(
      color: AppDesign.colors.gray50,
      child: Column(
        children: [
          _buildProfileSection(data),
          AppDesign.spacing.h24,
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  for (final group in ProfileMenu.groups) ...[
                    _buildMenuGroup(group),
                    if (group != ProfileMenu.groups.last) const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(ProfileResponse data) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        children: [
          _buildProfileAvatar(data),
          const SizedBox(height: 16),
          _buildProfileName(data),
          const SizedBox(height: 4),
          const SizedBox(height: 24),
          _buildStatistics(data),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar(ProfileResponse data) {
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

  Widget _buildVerificationBadge() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  Widget _buildProfileName(ProfileResponse data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          data.nickname,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 6),
        Icon(
          Icons.check_circle,
          color: Colors.blue[500],
          size: 16,
        ),
      ],
    );
  }

  Widget _buildStatistics(ProfileResponse data) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('내가 작성한 리뷰', data.writtenReviewsCount.toString(), () {}),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard('즐겨찾기한 리뷰', data.bookmarkCount.toString(), () {
            context.push(AppRoute.bookmarkedReviews.path);
          }),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String count, VoidCallback onTap) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: 1.0),
      duration: const Duration(milliseconds: 200),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppDesign.typo.body2(color: AppDesign.colors.gray900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    count,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuGroup(List<ProfileMenu> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: items.map((e) => _buildMenuItem(e, e == items.last)).toList(),
      ),
    );
  }

  Widget _buildMenuItem(ProfileMenu menu, bool isLast) {
    return InkWell(
      onTap: () async {
        switch (menu) {
          case ProfileMenu.logout:
            await ref.read(authRepositoryProvider).signOut();
            if (mounted) {
              context.go(AppRoute.signIn.path);
            }
            break;
          case ProfileMenu.contact:
            // TODO: Handle contact tap
            break;
          case ProfileMenu.termsOfService:
            // TODO: Handle terms tap
            break;
          case ProfileMenu.license:
            // TODO: Handle privacy tap
            break;
          case ProfileMenu.version:
            // TODO: Handle contact tap
            break;
          case ProfileMenu.withdraw:
            // TODO: Handle withdraw tap
            break;
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Row(
              children: [
                Text(
                  menu.title,
                  style: AppDesign.typo.body1SemiBold(color: menu.textColor),
                ),
                const Spacer(),
                if (menu != ProfileMenu.logout && menu != ProfileMenu.withdraw)
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
              ],
            ),
          ),
          if (!isLast)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 1, color: AppDesign.colors.gray200),
            ),
        ],
      ),
    );
  }
}
