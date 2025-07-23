import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/auth/response/auth_response.dart';
import 'package:viewith/feature/auth/presentation/entity/User.dart';

abstract class AuthRepository {
  Stream<User?> authStateChanges();

  Future<Result<AuthResponse, BaseError>> signInWithKakao();

  Future<Result<AuthResponse, BaseError>> signInWithApple({
    required String idToken,
    required String authorizationCode,
  });

  Future<User> signInAnonymously();

  Future<void> signOut();
}