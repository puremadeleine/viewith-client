import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/writing/search/controller/writing_venues_controller.dart';
import 'package:viewith/feature/writing/search/presentation/search_list_item.dart';
import 'package:viewith/feature/writing/search/presentation/search_screen_template.dart';
import 'package:viewith/ui/app_design.dart';

import '../../../../data/venue/response/venue.dart';

class WritingVenuesScreen extends ConsumerWidget {
  const WritingVenuesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venues = ref.watch(writingVenuesControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SearchScreenTemplate<Venue>(
        title: '공연장을 입력해주세요',
        subTitle: '어떤 공연장에서 공연을 관람하셨나요?',
        searchHint: '공연장 이름을 입력해주세요.',
        items: venues,
        onSearch: (text) {
          ref.read(writingVenuesControllerProvider.notifier).searchVenues(text);
        },
        itemBuilder: (context, venue, query) {
          return InkWell(
            onTap: () {
              print("Selected venue: ${venue.id}, ${venue.name}");
              ref.read(selectedVenueProvider.notifier).select(venue);
              print("Venue selected in provider: ${ref.read(selectedVenueProvider)}");
              context.pushNamed(AppRoute.writingSeatInfo.name);
            },
            child: SearchListItem(
              text: venue.name,
              subText: venue.location,
              query: query,
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
