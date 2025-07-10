// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helpControllerHash() => r'0eb96d91f545fed0f66cd8dc32dd2229426bcc3a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$HelpController
    extends BuildlessAutoDisposeAsyncNotifier<HelpListItem> {
  late final int id;

  FutureOr<HelpListItem> build(
    int id,
  );
}

/// See also [HelpController].
@ProviderFor(HelpController)
const helpControllerProvider = HelpControllerFamily();

/// See also [HelpController].
class HelpControllerFamily extends Family<AsyncValue<HelpListItem>> {
  /// See also [HelpController].
  const HelpControllerFamily();

  /// See also [HelpController].
  HelpControllerProvider call(
    int id,
  ) {
    return HelpControllerProvider(
      id,
    );
  }

  @override
  HelpControllerProvider getProviderOverride(
    covariant HelpControllerProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'helpControllerProvider';
}

/// See also [HelpController].
class HelpControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<HelpController, HelpListItem> {
  /// See also [HelpController].
  HelpControllerProvider(
    int id,
  ) : this._internal(
          () => HelpController()..id = id,
          from: helpControllerProvider,
          name: r'helpControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$helpControllerHash,
          dependencies: HelpControllerFamily._dependencies,
          allTransitiveDependencies:
              HelpControllerFamily._allTransitiveDependencies,
          id: id,
        );

  HelpControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<HelpListItem> runNotifierBuild(
    covariant HelpController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(HelpController Function() create) {
    return ProviderOverride(
      origin: this,
      override: HelpControllerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<HelpController, HelpListItem>
      createElement() {
    return _HelpControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HelpControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HelpControllerRef on AutoDisposeAsyncNotifierProviderRef<HelpListItem> {
  /// The parameter `id` of this provider.
  int get id;
}

class _HelpControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HelpController,
        HelpListItem> with HelpControllerRef {
  _HelpControllerProviderElement(super.provider);

  @override
  int get id => (origin as HelpControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
