import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/data/member/member_repository_providers.dart';

part 'current_user_provider.g.dart';

@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  Future<int?> build() async {
    try {
      final repository = ref.read(memberRepositoryProvider);
      final result = await repository.fetchProfile();
      
      return result.match(
        onSuccess: (profile) => profile.memberId,
        onFailure: (error) {
          print('🔍 CurrentUser Debug: Failed to fetch profile - ${error.message}');
          return null;
        },
      );
    } catch (e) {
      print('🔍 CurrentUser Debug: Exception occurred - $e');
      return null;
    }
  }
}
