import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/data/member/member_repository.dart';
import 'package:viewith/data/member/remote/remote_member_repository.dart';
import 'package:viewith/di/app_providers.dart';

part 'member_repository_providers.g.dart';

@riverpod
MemberRepository memberRepository(Ref ref) {
  return RemoteMemberRepository(client(ref));
}