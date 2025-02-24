// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewListControllerHash() =>
    r'f6c9c188e188fd0a7906bb52902760718941e78c';

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

abstract class _$ReviewListController
    extends BuildlessAutoDisposeAsyncNotifier<ReviewListState> {
  late final String id;

  FutureOr<ReviewListState> build(
    String id,
  );
}

/// See also [ReviewListController].
@ProviderFor(ReviewListController)
const reviewListControllerProvider = ReviewListControllerFamily();

/// See also [ReviewListController].
class ReviewListControllerFamily extends Family<AsyncValue<ReviewListState>> {
  /// See also [ReviewListController].
  const ReviewListControllerFamily();

  /// See also [ReviewListController].
  ReviewListControllerProvider call(
    String id,
  ) {
    return ReviewListControllerProvider(
      id,
    );
  }

  @override
  ReviewListControllerProvider getProviderOverride(
    covariant ReviewListControllerProvider provider,
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
  String? get name => r'reviewListControllerProvider';
}

/// See also [ReviewListController].
class ReviewListControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ReviewListController, ReviewListState> {
  /// See also [ReviewListController].
  ReviewListControllerProvider(
    String id,
  ) : this._internal(
          () => ReviewListController()..id = id,
          from: reviewListControllerProvider,
          name: r'reviewListControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reviewListControllerHash,
          dependencies: ReviewListControllerFamily._dependencies,
          allTransitiveDependencies:
              ReviewListControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ReviewListControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<ReviewListState> runNotifierBuild(
    covariant ReviewListController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ReviewListController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReviewListControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ReviewListController, ReviewListState>
      createElement() {
    return _ReviewListControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReviewListControllerProvider && other.id == id;
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
mixin ReviewListControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ReviewListState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ReviewListControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ReviewListController,
        ReviewListState> with ReviewListControllerRef {
  _ReviewListControllerProviderElement(super.provider);

  @override
  String get id => (origin as ReviewListControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
