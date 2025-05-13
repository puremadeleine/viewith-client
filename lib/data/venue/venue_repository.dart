import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/paginated_response.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/venue/response/seat_info.dart';
import 'package:viewith/data/venue/response/venue_detail.dart';
import 'package:viewith/data/venue/response/seat_detail.dart';
import 'request/review_params.dart';
import 'response/review.dart';
import 'response/venue.dart';

abstract class VenueRepository {
  Future<Result<VenueDetail, BaseError>> fetchVenue(String id);

  Future<Result<List<Venue>, BaseError>> fetchVenues();

  Future<Result<PaginatedResponse<List<Review>>, BaseError>> fetchReviews(ReviewParams params);

  Future<Result<List<Venue>, BaseError>> searchVenues(String keyword);

  Future<Result<List<SeatInfo>, BaseError>> fetchSeatInfo(String id);

  Future<Result<Review, BaseError>> fetchReview(int id);

  Future<Result<List<SectionInfo>, BaseError>> fetchSeatDetail(String id);

  Future<Result<void, BaseError>> createReview({
    required int venueId,
    required String section,
    required int seatRow,
    int? seatColumn,
    required String content,
    required double rating,
    List<String>? images,
  });
}
