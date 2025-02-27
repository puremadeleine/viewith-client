import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/venue/request/review_params.dart';
import 'package:viewith/data/venue/response/review.dart';
import 'package:viewith/data/venue/response/seat_info.dart';
import 'package:viewith/data/venue/response/venue_detail.dart';
import 'package:viewith/feature/seatmap/presentation/controller/state/review_list_state.dart';
import 'package:viewith/ui/widgets/chip_list.dart';

import '../../../../core/result/paginated_response.dart';
import '../../../../data/venue/venue_repository_providers.dart';

part 'review_list_controller.g.dart';

@riverpod
class ReviewListController extends _$ReviewListController {
  @override
  FutureOr<ReviewListState> build(String id) async {
    final venueResult = await ref.read(venueRepositoryProvider).fetchVenue(id);
    final reviewsResult = await fetchReviews();
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

  Future<Result<PaginatedResponse<List<Review>>, BaseError>> fetchReviews() async {
    final currentState = state.value;
    final ReviewParams params;
    if (currentState == null) {
      params = const ReviewParams();
    } else {
      int? parsedSeatRow;
      if (currentState.selectedFloor != null && currentState.selectedRow != null) {
        parsedSeatRow = int.parse(currentState.selectedRow!);
      }

      params = ReviewParams(
        sortType: currentState.sortType,
        floor: currentState.selectedFloor,
        row: parsedSeatRow,
      );
    }
    final reviewsResult = await ref.read(venueRepositoryProvider).fetchReviews(params);
    return reviewsResult;
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

  void removeFilterChip(FilterChipData chip) {
    final currentState = state.value;
    if (currentState == null) return;
    final newState = currentState.copyWith(
      sortType: chip.type == FilterType.sort ? ReviewSortType.defaultSort : currentState.sortType,
      selectedFloor: chip.type == FilterType.seat ? null : currentState.selectedFloor,
      selectedRow: chip.type == FilterType.seat ? null : currentState.selectedRow,
    );
    state = AsyncData(newState);
  }
}
