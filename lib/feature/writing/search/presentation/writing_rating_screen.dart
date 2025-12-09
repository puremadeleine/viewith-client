import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/writing/search/controller/writing_rating_controller.dart';
import 'package:viewith/feature/writing/search/controller/writing_review_controller.dart';
import 'package:viewith/feature/writing/search/controller/writing_seat_infos_controller.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/button/vi_button.dart';
import 'package:viewith/ui/widgets/button/vi_button_type.dart';
import 'package:viewith/ui/widgets/vi_slider.dart';
import '../controller/writing_venues_controller.dart';
import 'package:viewith/feature/writing/search/controller/writing_image_provider.dart';

class WritingRatingScreen extends ConsumerStatefulWidget {
  const WritingRatingScreen({super.key});

  @override
  ConsumerState<WritingRatingScreen> createState() => _WritingRatingScreenState();
}

class _WritingRatingScreenState extends ConsumerState<WritingRatingScreen> {
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    final venue = ref.watch(selectedVenueProvider);
    final seatInfo = ref.watch(writingSeatInfosControllerProvider);
    final currentRating = ref.watch(writingRatingProvider);

    if (venue == null) {
      return const Scaffold(
        body: Center(child: Text('공연장 정보가 없습니다.')),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle('이 자리 어떠셨어요?'),
                _buildSubTitle('5점 만점에 몇 점이신가요? 신중한 평가 부탁드려요!'),
                VISlider(
                  initialRating: currentRating,
                  onRatingChanged: (double rating) {
                    ref.read(writingRatingProvider.notifier).updateRating(rating);
                  },
                ),
                const Spacer(),
                _buildButton(context, ref, venue, seatInfo),
              ],
            ),
          ),
          if (_isUploading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
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
        if (_isUploading) return;
        
        final images = ref.read(writingImageProviderProvider);
        final imagePaths = images.map((x) => x.path).toList();
        if (seatInfo['section'] == null || seatInfo['row'] == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('좌석 정보가 올바르지 않습니다.')),
          );
          return;
        }

        setState(() {
          _isUploading = true;
        });

        try {
          if (seatInfo['section'] != null && seatInfo['row'] != null) {
            final rating = ref.read(writingRatingProvider);
            print('🔥 업로드 시 별점 값: $rating'); // 디버그 로그
            
            final reviewId = await ref.read(writingReviewProvider.notifier).submitReview(
                  venueId: venue.id,
                  section: seatInfo['section']!,
                  seatRow: seatInfo['row']!,
                  seatColumn: seatInfo['number'],
                  content: seatInfo['content'] ?? '',
                  rating: rating,
                  images: imagePaths,
                );
            
            print('🎉 생성된 리뷰 ID: $reviewId'); // 디버그 로그
            
            if (context.mounted) {
              // 모든 스택을 제거하고 홈 -> 리뷰 상세 순서로 네비게이션 스택 구성
              context.goNamed(
                AppRoute.reviewDetail.name,
                pathParameters: {'id': reviewId.toString()},
                extra: {
                  'fromHome': true, // 홈에서 온 것처럼 처리
                  'venueId': venue.id.toString(),
                },
              );
            }
          }
        } catch (e) {
          if (context.mounted) {
            setState(() {
              _isUploading = false;
            });
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
