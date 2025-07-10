import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/di/app_providers.dart';
import 'package:viewith/ui/widgets/dialog/guest_dialog.dart';
import 'package:viewith/ui/widgets/vi_navigation_bar.dart';
import 'package:viewith/ui/widgets/vi_navigation_item.dart';

class NavigationBar extends ConsumerWidget {
  const NavigationBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: VINavigationBar(
        items: const [
          VINavigationItem(
            icon: Icons.home,
            title: '홈',
          ),
          VINavigationItem(
            icon: Icons.person,
            title: '프로필',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => navigationShell.goBranch(index),
        onCenterButtonTap: () {
          final isGuestMode = ref.read(isGuestModeProvider);
          if (isGuestMode) {
            showGuestDialog(context, ref);
          } else {
            context.pushNamed(AppRoute.writingVenues.name);
          }
        },
      ),
    );
  }
}
