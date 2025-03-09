import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/home/presentation/controller/home_controller.dart';
import 'package:viewith/feature/home/presentation/widget/venue_item.dart';
import 'package:viewith/ui/app_design.dart';

import '../../../../data/venue/response/venue.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      body: state.when(
        data: (venues) => _buildBody(venues),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildBody(List<Venue> venues) {
    return SafeArea(
      child: Padding(
        padding: AppDesign.spacing.horizontal24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDesign.spacing.h32,
            _buildTitle('1열 사수 다람쥐님!\n시야를 확인해 보세요.'),
            AppDesign.spacing.h8,
            _buildSubTitle('전체 공연장 목록'),
            AppDesign.spacing.h4,
            const Divider(height: 1),
            _buildList(venues),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: AppDesign.typo.h1(),
    );
  }

  Widget _buildSubTitle(String subTitle) {
    return Text(
      subTitle,
      style: AppDesign.typo.h2(),
    );
  }

  Widget _buildList(List<Venue> venues) {
    return Expanded(
      child: ListView.separated(
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final performances = venues[index].performances ?? [];
          return Padding(
            padding: AppDesign.spacing.vertical8,
            child: GestureDetector(
              onTap: () {
                context.push('${AppRoute.seatmap.path}/${venues[index].id}', extra: {'name': venues[index].name});
              },
              child: VenueItem(
                name: venues[index].name,
                address: venues[index].location,
                images: const [],
                artists: performances.map((e) => e.artist).toList(),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: AppDesign.colors.gray200);
        },
      ),
    );
  }
}
