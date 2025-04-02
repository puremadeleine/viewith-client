import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/member/member_repository.dart';
import 'package:viewith/data/member/response/bookmark_response.dart';
import 'package:viewith/network/client.dart';
import 'package:viewith/core/result/api_response_parser.dart';

class RemoteMemberRepository extends MemberRepository {
  final Client _client;

  RemoteMemberRepository(this._client);

  @override
  Future<Result<List<BookmarkResponse>, BaseError>> fetchBookmarks() async {
    final response = await _client.get('/v1/members/bookmarks', requiresAuth: true);
    return response.toListResult(fromJson: BookmarkResponse.fromJson, key: 'bookmarks');
  }
}
