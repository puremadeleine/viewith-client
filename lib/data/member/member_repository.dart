import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/member/response/bookmark_response.dart';

abstract class MemberRepository {
  Future<Result<BookmarkListResponse, BaseError>> fetchBookmarks();
}
