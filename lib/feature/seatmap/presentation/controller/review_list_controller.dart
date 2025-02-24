import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/venue/request/review_params.dart';
import 'package:viewith/data/venue/response/review.dart';
import 'package:viewith/data/venue/response/seat_info.dart';
import 'package:viewith/data/venue/response/venue_detail.dart';
import 'package:viewith/feature/seatmap/presentation/controller/state/review_list_state.dart';

import '../../../../core/result/paginated_response.dart';
import '../../../../data/venue/venue_repository_providers.dart';

part 'review_list_controller.g.dart';

@riverpod
class ReviewListController extends _$ReviewListController {
  @override
  FutureOr<ReviewListState> build(String id) async {
    final venueResult = await ref.read(venueRepositoryProvider).fetchVenue(id);
    final reviewsResult = await ref.read(venueRepositoryProvider).fetchReviews(const ReviewParams());
    final seatsResult = await ref.read(venueRepositoryProvider).fetchSeatInfo(id);
    return Result.combine([
      venueResult,
      reviewsResult,
      seatsResult,
    ]).match<ReviewListState>(
      onSuccess: (results) {
        final VenueDetail venues = results[0];
        final PaginatedResponse<List<Review>> reviews = results[1];
        final List<SeatInfo> seats = results[2];
        return ReviewListState(
          id: id,
          venueInfo: AsyncData(venues),
          seatInfo: AsyncData(seats),
          reviews: AsyncData(reviews.list),
        );
      },
      onFailure: (error) => throw error,
    );
  }

  void setSortOption(ReviewSortType option) {
    final currentState = state.value;
    if (currentState == null) return;
    final newState = currentState.copyWith(sortType: option);
    state = AsyncData(newState);
  }

  void setFloor(String floor) {
    final currentState = state.value;
    if (currentState == null) return;
    final newState = currentState.copyWith(selectedFloor: floor);
    state = AsyncData(newState);
    print(state);
  }

  void setRow(String row) {
    final currentState = state.value;
    if (currentState == null) return;
    final newState = currentState.copyWith(selectedRow: row);
    state = AsyncData(newState);
  }
}
