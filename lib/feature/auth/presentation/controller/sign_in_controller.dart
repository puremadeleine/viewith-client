import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/data/auth/auth_repository_providers.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInScreenController extends _$SignInScreenController {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> signInWithKakao() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(
      () {
        return authRepository.signInWithKakao();
      },
    );
  }

  Future<void> signInWithApple({
    required String idToken,
    required String authorizationCode,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(
      () {
        return authRepository.signInWithApple(
          idToken: idToken,
          authorizationCode: authorizationCode,
        );
      },
    );
  }
}
