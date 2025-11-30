import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:viewith/core/result/api_response_parser.dart';
import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/paginated_response.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/venue/request/review_params.dart';
import 'package:viewith/data/venue/request/report_review_request.dart';
import 'package:viewith/data/venue/response/review.dart';
import 'package:viewith/data/venue/response/seat_info.dart';
import 'package:viewith/data/venue/response/venue_detail.dart';
import 'package:viewith/data/venue/response/create_review_response.dart';
import 'package:viewith/network/client.dart';

import '../response/venue.dart';
import '../venue_repository.dart';
import 'package:viewith/data/venue/response/seat_detail.dart';

class RemoteVenueRepository extends VenueRepository {
  final Client _client;

  RemoteVenueRepository(this._client);

  @override
  Future<Result<List<Venue>, BaseError>> fetchVenues() async {
    final response = await _client.get('/v1/venues');
    final result = response.toListResult(fromJson: Venue.fromJson, key: 'venues');
    return result;
  }

  @override
  Future<Result<List<Venue>, BaseError>> searchVenues(String keyword) async {
    final response = await _client.get('/v1/venues/search', queryParameters: {'keyword': keyword});
    print('searchVenues response: ${response.data}');
    return response.toListResult(fromJson: Venue.fromJson, key: 'venues');
  }

  @override
  Future<Result<VenueDetail, BaseError>> fetchVenue(String id) async {
    final response = await _client.get('/v1/venues/$id');
    return response.toResult(fromJson: VenueDetail.fromJson);
  }

  @override
  Future<Result<PaginatedResponse<List<Review>>, BaseError>> fetchReviews(ReviewParams params) async {
    final queryParams = params.toJson();
    final response = await _client.get('/v1/reviews/list', queryParameters: queryParams);
    return response.toPaginatedResult((json) => (json as List).map((e) => Review.fromJson(e)).toList());
  }

  @override
  Future<Result<List<SeatInfo>, BaseError>> fetchSeatInfo(String id) async {
    final response = await _client.get('/v1/venues/$id/filter');
    return response.toListResult(fromJson: SeatInfo.fromJson, key: 'seat_infos');
  }

  @override
  Future<Result<Review, BaseError>> fetchReview(int id) async {
    final response = await _client.get('/v1/reviews/$id', requiresAuth: true);
    return response.toResult(fromJson: Review.fromJson);
  }

  @override
  Future<Result<List<SectionInfo>, BaseError>> fetchSeatDetail(String id) async {
    final response = await _client.get('/v1/venues/$id/seats');
    return response.toListResult(fromJson: SectionInfo.fromJson, key: 'seat_infos');
  }

  @override
  Future<Result<CreateReviewResponse, BaseError>> createReview({
    required int venueId,
    required String section,
    required String seatRow,
    String? seatColumn,
    required String content,
    required double rating,
    List<String>? images,
  }) async {
    final createReviewReqDto = {
      'venue_id': venueId,
      'section': section,
      'seat_row': seatRow,
      if (seatColumn != null) 'seat_column': seatColumn,
      'content': content,
      'rating': rating,
    };

    final List<MultipartFile> imageFiles = [];
    if (images != null && images.isNotEmpty) {
      for (final imagePath in images) {
        final fileName = imagePath.split('/').isNotEmpty ? imagePath.split('/').last : 'image';
        imageFiles.add(await MultipartFile.fromFile(imagePath, filename: fileName));
      }
    }

    final formData = FormData.fromMap({
      'CreateReviewReqDto': MultipartFile.fromString(
        jsonEncode(createReviewReqDto),
        contentType: MediaType('application', 'json'),
      ),
      if (imageFiles.isNotEmpty) 'images': imageFiles,
    });

    final response = await _client.post(
      '/v1/reviews',
      data: formData,
    );
    return response.toResult(fromJson: CreateReviewResponse.fromJson);
  }

  @override
  Future<Result<void, BaseError>> deleteReview(int reviewId) async {
    final response = await _client.delete(
      '/v1/reviews/$reviewId',
      requiresAuth: true,
    );
    return response.toVoidResult();
  }

  @override
  Future<Result<void, BaseError>> reportReview(int reviewId, ReportReviewRequest request) async {
    final response = await _client.post(
      '/v1/reviews/$reviewId/report',
      data: request.toJson(),
      requiresAuth: true,
    );
    return response.toVoidResult();
  }

  @override
  Future<Result<void, BaseError>> bookmarkSeat({
    required int venueId,
    required int seatId,
  }) async {
    final response = await _client.post(
      '/v1/venues/$venueId/seats/$seatId/bookmarks',
      requiresAuth: true,
    );
    return response.toVoidResult();
  }

  @override
  Future<Result<void, BaseError>> deleteSeatBookmark({
    required int venueId,
    required int seatId,
  }) async {
    final response = await _client.delete(
      '/v1/venues/$venueId/seats/$seatId/bookmarks',
      requiresAuth: true,
    );
    return response.toVoidResult();
  }
}
