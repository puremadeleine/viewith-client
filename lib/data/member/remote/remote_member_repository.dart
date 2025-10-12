import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/member/member_repository.dart';
import 'package:viewith/data/member/response/bookmark_response.dart';
import 'package:viewith/data/member/response/profile_response.dart';
import 'package:viewith/network/client.dart';
import 'package:viewith/core/result/api_response_parser.dart';
import 'package:viewith/core/result/paginated_response.dart';
import 'package:viewith/data/venue/response/review.dart';

class RemoteMemberRepository extends MemberRepository {
  final Client _client;

  RemoteMemberRepository(this._client);

  @override
  Future<Result<List<BookmarkResponse>, BaseError>> fetchBookmarks() async {
    final response = await _client.get('/v1/members/bookmarks', requiresAuth: true);
    return response.toListResult(fromJson: BookmarkResponse.fromJson, key: 'bookmarks');
  }

  @override
  Future<Result<ProfileResponse, BaseError>> fetchProfile() async {
    final response = await _client.get('/v1/members/profiles', requiresAuth: true);
    return response.toResult(fromJson: ProfileResponse.fromJson);
  }

  @override
  Future<Result<PaginatedResponse<List<Review>>, BaseError>> fetchWrittenReviews({int page = 1, int size = 10}) async {
    final response = await _client.get(
      '/v1/members/reviews',
      queryParameters: {'page': page, 'size': size},
      requiresAuth: true,
    );
    return response.toPaginatedResult((json) => (json as List).map((e) => Review.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Future<Result<void, BaseError>> deleteMember() async {
    final response = await _client.delete('/v1/members', requiresAuth: true);
    return response.toVoidResult();
  }
}
