import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/core/result/paginated_response.dart';
import 'package:viewith/data/member/member_repository_providers.dart';
import 'package:viewith/data/venue/response/review.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/error_widget.dart' as error_widget;
import 'package:viewith/feature/seatmap/presentation/widget/review_item.dart';

// export for use in other screens
final writtenReviewsProvider = FutureProvider<PaginatedResponse<List<Review>>>((ref) async {
  final repo = ref.read(memberRepositoryProvider);
  final result = await repo.fetchWrittenReviews();
  return result.match(
    onSuccess: (data) => data,
    onFailure: (error) => throw Exception('내가 작성한 리뷰 API 호출 실패: $error'),
  );
});

class WrittenReviewsScreen extends ConsumerWidget {
  const WrittenReviewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('내가 작성한 리뷰', style: AppDesign.typo.title2bold())),
      body: ref.watch(writtenReviewsProvider).when(
            data: (page) => _Content(reviews: page.list),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => error_widget.ErrorWidget(
              error: error_widget.mapExceptionToError(err),
              onRetry: () => ref.invalidate(writtenReviewsProvider),
            ),
          ),
    );
  }
}

class _Content extends StatefulWidget {
  final List<Review> reviews;
  const _Content({required this.reviews});

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: ListView.separated(
        controller: _controller,
        itemCount: widget.reviews.length,
        itemBuilder: (context, index) {
          final review = widget.reviews[index];
          final imageUrl = review.imageList.isNotEmpty ? review.imageList.first : '';
          return GestureDetector(
            onTap: () {
             context.push('${AppRoute.reviewDetail.path}/${review.reviewId}');
            },
            behavior: HitTestBehavior.opaque,
            child: ReviewItem(
              imageUrl: imageUrl,
              concert: '공연명',
              seat: review.seatName,
              rating: review.rating,
              review: review.content,
              date: review.createdAt,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),
    );
  }
}


