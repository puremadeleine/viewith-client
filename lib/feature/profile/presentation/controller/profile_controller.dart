import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/member/member_repository_providers.dart';
import 'package:viewith/data/member/response/profile_response.dart';
part 'profile_controller.g.dart';

@Riverpod(keepAlive: true)
Future<Result<ProfileResponse, BaseError>> fetchProfile(Ref ref) async {
  final repository = ref.watch(memberRepositoryProvider);
  return repository.fetchProfile();
}
