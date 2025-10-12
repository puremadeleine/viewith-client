import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/data/venue/response/review.dart';
import 'package:viewith/data/venue/venue_repository_providers.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/core/result/base_error.dart';

part 'review_detail_controller.g.dart';

@riverpod
Future<Result<Review, BaseError>> reviewDetail(ReviewDetailRef ref, int reviewId) async {
  final repository = ref.watch(venueRepositoryProvider);
  return repository.fetchReview(reviewId);
}
