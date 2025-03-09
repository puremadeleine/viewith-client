import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/di/app_providers.dart';

import 'remote/remote_auth_repository.dart';
import 'auth_repository.dart';

part 'auth_repository_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return RemoteAuthRepository(client(ref), ref.read(tokenHandlerProvider));
}