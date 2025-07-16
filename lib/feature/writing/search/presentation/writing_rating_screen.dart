import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/route/app_route.dart';
import '../../../../ui/app_design.dart';
import '../../../../ui/widgets/button/vi_button.dart';
import '../../../../ui/widgets/button/vi_button_type.dart';
import '../../../../ui/widgets/vi_slider.dart';
import '../controller/writing_rating_controller.dart';
import '../controller/writing_review_controller.dart';
import '../controller/writing_venues_controller.dart';
import '../controller/writing_seat_infos_controller.dart';

class WritingRatingScreen extends ConsumerWidget {
  const WritingRatingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(selectedVenueProvider);
    final seatInfo = ref.watch(writingSeatInfosControllerProvider);

    if (venue == null) {
      return const Scaffold(
        body: Center(child: Text('공연장 정보가 없습니다.')),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle('이 자리 어떠셨어요?'),
            _buildSubTitle('5점 만점에 몇 점이신가요? 신중한 평가 부탁드려요!'),
            VISlider(
              onRatingChanged: (double rating) {
                ref.read(writingRatingProvider.notifier).updateRating(rating);
              },
            ),
            const Spacer(),
            _buildButton(context, ref, venue, seatInfo),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(text, style: AppDesign.typo.title1());
  }

  Widget _buildSubTitle(String text) {
    return Text(text, style: AppDesign.typo.body2(color: AppDesign.colors.gray600));
  }

  Widget _buildButton(BuildContext context, WidgetRef ref, venue, seatInfo) {
    return VIButton(
      onTap: () async {
        if (seatInfo['section'] == null || seatInfo['row'] == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('좌석 정보가 올바르지 않습니다.')),
          );
          return;
        }

        try {
          await ref.read(writingReviewProvider.notifier).submitReview(
            venueId: venue.id,
            section: seatInfo['section']!,
            seatRow: seatInfo['row']!,
            seatColumn: seatInfo['number'],
            content: 'test',
            rating: ref.read(writingRatingProvider),
            images: [], // TODO: Get images from review screen
          );
          if (context.mounted) {
            context.pop();
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('리뷰 제출에 실패했습니다: $e')),
            );
          }
        }
      },
      type: VIButtonType.primary,
      text: '완료',
    );
  }
}
