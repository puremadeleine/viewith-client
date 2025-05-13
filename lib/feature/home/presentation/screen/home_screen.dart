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
      backgroundColor: AppDesign.colors.white,
      appBar: AppBar(
        title: Text('VIEWITH', style: AppDesign.typo.title1ExtraBold(color: AppDesign.colors.white)),
        centerTitle: false,
        backgroundColor: AppDesign.colors.gray900,
        elevation: 0,
      ),
      body: state.when(
        data: (venues) => _buildBody(venues),
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

  Widget _buildBody(List<Venue> venues) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: AppDesign.spacing.horizontal24,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                AppDesign.spacing.h32,
                _buildTitle('1열 사수 다람쥐님!\n시야를 확인해 보세요.'),
                AppDesign.spacing.h24,
              ]),
            ),
          ),
          SliverPadding(
            padding: AppDesign.spacing.horizontal24,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final performances = venues[index].performances ?? [];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push(
                            '${AppRoute.seatmap.path}/${venues[index].id}',
                            extra: {'name': venues[index].name},
                          );
                        },
                        child: VenueItem(
                          name: venues[index].name,
                          address: venues[index].location,
                          images: venues[index].performances?.map((e) => e.imageUrl).toList() ?? [],
                          artists: performances.map((e) => e.artist).toList(),
                        ),
                      ),
                      if (index != venues.length - 1)
                        Divider(
                          color: AppDesign.colors.gray100,
                          height: 32,
                          thickness: 1,
                        ),
                    ],
                  );
                },
                childCount: venues.length,
              ),
            ),
          ),
          SliverPadding(
            padding: AppDesign.spacing.vertical24,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: AppDesign.typo.title1ExtraBold(color: AppDesign.colors.gray900),
    );
  }
}
