import 'dart:async';

import 'package:flutter/material.dart' hide NavigationBar;
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewith/di/app_providers.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/auth/presentation/screen/sign_in_screen.dart';
import 'package:viewith/app/route/navigation_bar.dart';
import 'package:viewith/feature/help/presentation/help_detail_screen.dart';
import 'package:viewith/feature/help/presentation/help_list_screen.dart';
import 'package:viewith/feature/home/presentation/screen/home_screen.dart';
import 'package:viewith/feature/profile/presentation/screen/profile_screen.dart';
import 'package:viewith/feature/profile/presentation/screen/bookmark_screen.dart';
import 'package:viewith/feature/seatmap/presentation/screen/review_detail_screen.dart';
import 'package:viewith/feature/seatmap/presentation/screen/review_list_screen.dart';
import 'package:viewith/feature/writing/search/presentation/writing_performance_screen.dart';
import 'package:viewith/feature/writing/search/presentation/writing_rating_screen.dart';
import 'package:viewith/feature/writing/search/presentation/writing_review_screen.dart';
import 'package:viewith/feature/writing/search/presentation/writing_venues_screen.dart';
import 'package:viewith/feature/writing/search/presentation/writing_seat_info_screen.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final tokenHandler = ref.watch(tokenHandlerProvider);

  return GoRouter(
    initialLocation: AppRoute.signIn.path,
    refreshListenable: GoRouterRefreshStream(ref.watch(isGuestModeProvider.notifier).stream),
    redirect: (context, state) async {
      final isGuestMode = ref.read(isGuestModeProvider);
      if (isGuestMode) {
        return null;
      }

      final hasTokens = await tokenHandler.hasTokens();
      final isSignInRoute = state.matchedLocation == AppRoute.signIn.path;

      if (!hasTokens && !isSignInRoute) {
        return AppRoute.signIn.path;
      }

      if (hasTokens && isSignInRoute) {
        return AppRoute.home.path;
      }

      return null;
    },
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
              routes: [
                GoRoute(
                  path: AppRoute.bookmarkedReviews.path,
                  name: AppRoute.bookmarkedReviews.name,
                  builder: (context, state) => const BookmarkScreen(),
                )
              ],
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
        ],
      ),
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
            path: '${AppRoute.help.path}/:id',
            name: AppRoute.help.name,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return HelpDetailScreen(id: int.parse(id));
            },
          ),
        ],
      ),
      GoRoute(
        path: '${AppRoute.reviewDetail.path}/:id',
        name: AppRoute.reviewDetail.name,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ReviewDetailScreen(id: int.parse(id));
        },
      ),
    ],
  );
});
