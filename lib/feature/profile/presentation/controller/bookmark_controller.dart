import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/data/member/member_repository_providers.dart';
import 'package:viewith/data/member/response/bookmark_response.dart';

import '../../../../core/result/result.dart';

part 'bookmark_controller.g.dart';

@riverpod
Future<Result<List<BookmarkResponse>, BaseError>> fetchBookmarks(Ref ref) async {
  final repository = ref.watch(memberRepositoryProvider);
  return repository.fetchBookmarks();
}
