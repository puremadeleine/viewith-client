import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/app/route/navigation_bar.dart';
import 'package:viewith/feature/auth/presentation/screen/sign_in_screen.dart';
import 'package:viewith/feature/help/presentation/help_detail_screen.dart';
import 'package:viewith/feature/help/presentation/help_list_screen.dart';
import 'package:viewith/feature/home/presentation/screen/home_screen.dart';
import 'package:viewith/feature/profile/presentation/screen/profile_screen.dart';
import 'package:viewith/feature/seatmap/presentation/screen/review_detail_screen.dart';
import 'package:viewith/feature/seatmap/presentation/screen/review_list_screen.dart';
import 'package:viewith/feature/writing/search/presentation/writing_performance_screen.dart';
import 'package:viewith/feature/writing/search/presentation/writing_rating_screen.dart';
import 'package:viewith/feature/writing/search/presentation/writing_review_screen.dart';
import 'package:viewith/feature/writing/search/presentation/writing_venues_screen.dart';

import '../../feature/writing/search/presentation/writing_seat_info_screen.dart';

final router = GoRouter(
  initialLocation: AppRoute.signIn.path,
  routes: [
    GoRoute(
      path: AppRoute.signIn.path,
      name: AppRoute.signIn.name,
      builder: (context, state) => const SignInScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return NavigationBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoute.home.path,
            name: AppRoute.home.name,
            builder: (context, state) => const HomeScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoute.profile.path,
            name: AppRoute.profile.name,
            builder: (context, state) => const ProfileScreen(),
          ),
        ]),
      ],
    ),
    GoRoute(
        path: AppRoute.writingVenues.path,
        name: AppRoute.writingVenues.name,
        builder: (context, state) => const WritingVenuesScreen(),
        routes: [
          GoRoute(
            path: AppRoute.writingSeatInfo.path,
            name: AppRoute.writingSeatInfo.name,
            builder: (context, state) => const WritingSeatInfoScreen(),
            routes: [
              GoRoute(
                path: AppRoute.writingPerformance.path,
                name: AppRoute.writingPerformance.name,
                builder: (context, state) => const WritingPerformanceScreen(),
                routes: [
                  GoRoute(
                    path: AppRoute.writingReview.path,
                    name: AppRoute.writingReview.name,
                    builder: (context, state) => const WritingReviewScreen(),
                    routes: [
                      GoRoute(
                        path: AppRoute.writingRating.path,
                        name: AppRoute.writingRating.name,
                        builder: (context, state) => const WritingRatingScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),
    GoRoute(
      path: '${AppRoute.seatmap.path}/:id',
      name: AppRoute.seatmap.name,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final extra = state.extra as Map<String, dynamic>;
        final name = extra['name'] as String;
        return ReviewListScreen(id: id, venueName: name);
      },
    ),
    GoRoute(
        path: AppRoute.helpList.path,
        name: AppRoute.helpList.name,
        builder: (context, state) => const HelpListScreen(),
        routes: [
          GoRoute(
            path: AppRoute.help.path,
            name: AppRoute.help.name,
            builder: (context, state) => const HelpDetailScreen(),
          ),
        ]),
    GoRoute(
      path: AppRoute.reviewDetail.path,
      name: AppRoute.reviewDetail.name,
      builder: (context, state) => ReviewDetailScreen()
    )
  ],
);
