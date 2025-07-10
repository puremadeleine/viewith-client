import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/network/client.dart';
import 'package:viewith/network/token_handler.dart';

part 'app_providers.g.dart';

final isGuestModeProvider = StateProvider<bool>((ref) => false);

@Riverpod(keepAlive: true)
TokenHandler tokenHandler(Ref ref) {
  return TokenHandler();
}

@Riverpod(keepAlive: true)
Client client(Ref ref) {
  return Client(ref.read(tokenHandlerProvider));
}