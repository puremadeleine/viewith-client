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

      final reviewsResult = await fetchReviews(id);
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

  Future<Result<PaginatedResponse<List<Review>>, BaseError>> fetchReviews([String? venueId]) async {
    final currentState = state.value;
    
    // venueId가 제공되지 않으면 currentState에서 가져오기
    final targetVenueId = venueId ?? currentState?.id;
    if (targetVenueId == null) {
      throw Exception('Venue ID is required');
    }
    
    final params = ReviewParams(
      venueId: targetVenueId,
      sortType: currentState?.sortType ?? ReviewSortType.latest,
      floor: currentState?.selectedFloor,
      // seat_row는 서버에서 문자열로 처리되므로 그대로 전달
      row: currentState?.selectedRow,
    );
    
    final reviewsResult = await ref.read(venueRepositoryProvider).fetchReviews(params);
    return reviewsResult;
  }

  void setSortOption(ReviewSortType option) async {
    final currentState = state.value;
    if (currentState == null) return;
    
    // 상태 먼저 업데이트
    final newState = currentState.copyWith(sortType: option);
    state = AsyncData(newState);
    
    // 새로운 정렬 조건으로 리뷰 데이터 다시 가져오기
    try {
      final reviewsResult = await fetchReviews();
      final reviews = await reviewsResult.match(
        onSuccess: (data) => data,
        onFailure: (error) => throw Exception('Review API 호출 실패: $error'),
      );
      
      final updatedState = newState.copyWith(reviews: AsyncData(reviews.list));
      state = AsyncData(updatedState);
    } catch (error) {
      final errorState = newState.copyWith(reviews: AsyncError(error, StackTrace.current));
      state = AsyncData(errorState);
    }
  }

  void setFloor(String floor) async {
    final currentState = state.value;
    if (currentState == null) return;
    
    // 상태 먼저 업데이트
    final newState = currentState.copyWith(selectedFloor: floor);
    state = AsyncData(newState);
    
    // 새로운 필터 조건으로 리뷰 데이터 다시 가져오기
    try {
      final reviewsResult = await fetchReviews();
      final reviews = await reviewsResult.match(
        onSuccess: (data) => data,
        onFailure: (error) => throw Exception('Review API 호출 실패: $error'),
      );
      
      final updatedState = newState.copyWith(reviews: AsyncData(reviews.list));
      state = AsyncData(updatedState);
    } catch (error) {
      final errorState = newState.copyWith(reviews: AsyncError(error, StackTrace.current));
      state = AsyncData(errorState);
    }
  }

  void setRow(String row) async {
    final currentState = state.value;
    if (currentState == null) return;
    
    // 상태 먼저 업데이트
    final newState = currentState.copyWith(selectedRow: row);
    state = AsyncData(newState);
    
    // 새로운 필터 조건으로 리뷰 데이터 다시 가져오기
    try {
      final reviewsResult = await fetchReviews();
      final reviews = await reviewsResult.match(
        onSuccess: (data) => data,
        onFailure: (error) => throw Exception('Review API 호출 실패: $error'),
      );
      
      final updatedState = newState.copyWith(reviews: AsyncData(reviews.list));
      state = AsyncData(updatedState);
    } catch (error) {
      final errorState = newState.copyWith(reviews: AsyncError(error, StackTrace.current));
      state = AsyncData(errorState);
    }
  }

  void removeFilterChip(FilterChipData chip) async {
    final currentState = state.value;
    if (currentState == null) return;
    
    // 상태 먼저 업데이트
    final newState = currentState.copyWith(
      sortType: chip.type == FilterType.sort ? ReviewSortType.defaultSort : currentState.sortType,
      selectedFloor: chip.type == FilterType.seat ? null : currentState.selectedFloor,
      selectedRow: chip.type == FilterType.seat ? null : currentState.selectedRow,
    );
    state = AsyncData(newState);
    
    // 새로운 필터 조건으로 리뷰 데이터 다시 가져오기
    try {
      final reviewsResult = await fetchReviews();
      final reviews = await reviewsResult.match(
        onSuccess: (data) => data,
        onFailure: (error) => throw Exception('Review API 호출 실패: $error'),
      );
      
      final updatedState = newState.copyWith(reviews: AsyncData(reviews.list));
      state = AsyncData(updatedState);
    } catch (error) {
      final errorState = newState.copyWith(reviews: AsyncError(error, StackTrace.current));
      state = AsyncData(errorState);
    }
  }
}
