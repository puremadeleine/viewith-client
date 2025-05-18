import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/member/response/bookmark_response.dart';
import 'package:viewith/data/member/response/profile_response.dart';

abstract class MemberRepository {
  Future<Result<List<BookmarkResponse>, BaseError>> fetchBookmarks();

  Future<Result<ProfileResponse, BaseError>> fetchProfile();
}
