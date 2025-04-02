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
    try {
      final venueResult = await ref.read(venueRepositoryProvider).fetchVenue(id);
      final VenueDetail venue = await venueResult.match(
        onSuccess: (data) => data,
        onFailure: (error) => throw Exception('Venue API 호출 실패: $error'),
      );

      final reviewsResult = await fetchReviews();
      final PaginatedResponse<List<Review>> reviews = await reviewsResult.match(
        onSuccess: (data) => data,
        onFailure: (error) => throw Exception('Review API 호출 실패: $error'),
      );

      final seatsResult = await ref.read(venueRepositoryProvider).fetchSeatInfo(id);
      final List<SeatInfo> seats = await seatsResult.match(
        onSuccess: (data) => data,
        onFailure: (error) => throw Exception('Seat Info API 호출 실패: $error'),
      );

      return ReviewListState(
        id: id,
        venueInfo: AsyncData(venue),
        seatInfo: AsyncData(seats),
        reviews: AsyncData(reviews.list),
      );
    } catch (error) {
      return ReviewListState(
        id: id,
        venueInfo: AsyncError(error, StackTrace.current),
        seatInfo: AsyncError(error, StackTrace.current),
        reviews: AsyncError(error, StackTrace.current),
      );
    }
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
