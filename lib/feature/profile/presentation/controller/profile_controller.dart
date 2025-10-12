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

@riverpod
class WithdrawController extends _$WithdrawController {
  @override
  FutureOr<void> build() {}

  Future<Result<void, BaseError>> withdrawMember() async {
    state = const AsyncLoading();
    final repository = ref.watch(memberRepositoryProvider);
    final result = await repository.deleteMember();
    
    state = result.match(
      onSuccess: (_) => const AsyncData(null),
      onFailure: (error) => AsyncError(error, StackTrace.current),
    );
    
    return result;
  }
}
