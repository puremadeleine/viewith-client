// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchProfileHash() => r'9b542dc71ae1d5e2e0e15f0fe8b3775a99815f96';

/// See also [fetchProfile].
@ProviderFor(fetchProfile)
final fetchProfileProvider =
    FutureProvider<Result<ProfileResponse, BaseError>>.internal(
  fetchProfile,
  name: r'fetchProfileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchProfileRef = FutureProviderRef<Result<ProfileResponse, BaseError>>;
String _$withdrawControllerHash() =>
    r'd8d1e87e94b59343e6ca107b2f4c9b94642a350a';

/// See also [WithdrawController].
@ProviderFor(WithdrawController)
final withdrawControllerProvider =
    AutoDisposeAsyncNotifierProvider<WithdrawController, void>.internal(
  WithdrawController.new,
  name: r'withdrawControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$withdrawControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WithdrawController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
