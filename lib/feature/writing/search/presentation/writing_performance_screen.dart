import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/writing/search/controller/writing_performances_controller.dart';
import 'package:viewith/feature/writing/search/presentation/search_screen_template.dart';
import 'package:viewith/feature/writing/search/presentation/search_list_item.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/data/performance/response/performance.dart';

class WritingPerformanceScreen extends ConsumerWidget {
  const WritingPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final performances = ref.watch(writingPerformancesControllerProvider);
    final controller = ref.read(writingPerformancesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('공연 선택'),
      ),
      body: SearchScreenTemplate<Performance>(
        title: '공연을 선택해주세요',
        subTitle: '어떤 공연을 관람하셨나요?',
        searchHint: '공연명을 입력해주세요',
        items: performances,
        itemBuilder: (context, performance, searchText) {
          return InkWell(
            onTap: () {
              controller.selectPerformance(performance);
              context.pushNamed(AppRoute.writingReview.name);
            },
            child: SearchListItem(
              text: performance.name,
              subText: performance.venueName,
              query: searchText,
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(color: AppDesign.colors.gray200),
        onSearch: (text) {
          controller.searchPerformances(text);
        },
      ),
    );
  }
}
