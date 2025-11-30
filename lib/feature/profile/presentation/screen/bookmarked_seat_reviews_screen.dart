import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/core/result/paginated_response.dart';
import 'package:viewith/data/venue/request/review_params.dart';
import 'package:viewith/data/venue/response/review.dart';
import 'package:viewith/data/venue/venue_repository_providers.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/error_widget.dart' as error_widget;
import 'package:viewith/feature/seatmap/presentation/widget/review_item.dart';

class BookmarkedSeatReviewsArgs {
  final int venueId;
  final String venueName;
  final String floor;
  final String? section;
  final String? row;

  const BookmarkedSeatReviewsArgs({
    required this.venueId,
    required this.venueName,
    required this.floor,
    this.section,
    this.row,
  });
}

final bookmarkedSeatReviewsProvider =
    FutureProvider.family<PaginatedResponse<List<Review>>, BookmarkedSeatReviewsArgs>((ref, args) async {
  final repo = ref.read(venueRepositoryProvider);
  final params = ReviewParams(
    venueId: args.venueId.toString(),
    sortType: ReviewSortType.defaultSort,
    floor: args.floor,
    section: args.section,
    row: args.row,
  );

  final result = await repo.fetchReviews(params);
  return result.match(
    onSuccess: (data) => data,
    onFailure: (error) => throw Exception('즐겨찾기 좌석 후기 리스트 API 호출 실패: $error'),
  );
});

class BookmarkedSeatReviewsScreen extends ConsumerWidget {
  final BookmarkedSeatReviewsArgs args;

  const BookmarkedSeatReviewsScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '좌석 후기',
          style: AppDesign.typo.title2bold(),
        ),
      ),
      body: ref.watch(bookmarkedSeatReviewsProvider(args)).when(
            data: (page) => _Content(reviews: page.list),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => error_widget.ErrorWidget(
              error: error_widget.mapExceptionToError(err),
              onRetry: () => ref.invalidate(bookmarkedSeatReviewsProvider(args)),
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
    if (widget.reviews.isEmpty) {
      return Center(
        child: Text(
          '해당 좌석 후기가 없습니다.',
          style: AppDesign.typo.body2(),
        ),
      );
    }

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


