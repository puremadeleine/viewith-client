import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/navigation_bar.dart';
import 'package:viewith/feature/home/presentation/screen/home_screen.dart';
import 'package:viewith/feature/seatmap/presentation/screen/review_list_screen.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return NavigationBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/review',
            builder: (context, state) => const ReviewListScreen(),
          ),
        ])
      ],
    ),
  ],
);
