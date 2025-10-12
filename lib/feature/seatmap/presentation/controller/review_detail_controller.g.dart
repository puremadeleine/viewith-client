// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewDetailHash() => r'f233b6fde42bf2d36d45775df526b9f8e52ea1e3';

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

/// See also [reviewDetail].
@ProviderFor(reviewDetail)
const reviewDetailProvider = ReviewDetailFamily();

/// See also [reviewDetail].
class ReviewDetailFamily extends Family<AsyncValue<Result<Review, BaseError>>> {
  /// See also [reviewDetail].
  const ReviewDetailFamily();

  /// See also [reviewDetail].
  ReviewDetailProvider call(
    int reviewId,
  ) {
    return ReviewDetailProvider(
      reviewId,
    );
  }

  @override
  ReviewDetailProvider getProviderOverride(
    covariant ReviewDetailProvider provider,
  ) {
    return call(
      provider.reviewId,
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
  String? get name => r'reviewDetailProvider';
}

/// See also [reviewDetail].
class ReviewDetailProvider
    extends AutoDisposeFutureProvider<Result<Review, BaseError>> {
  /// See also [reviewDetail].
  ReviewDetailProvider(
    int reviewId,
  ) : this._internal(
          (ref) => reviewDetail(
            ref as ReviewDetailRef,
            reviewId,
          ),
          from: reviewDetailProvider,
          name: r'reviewDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reviewDetailHash,
          dependencies: ReviewDetailFamily._dependencies,
          allTransitiveDependencies:
              ReviewDetailFamily._allTransitiveDependencies,
          reviewId: reviewId,
        );

  ReviewDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reviewId,
  }) : super.internal();

  final int reviewId;

  @override
  Override overrideWith(
    FutureOr<Result<Review, BaseError>> Function(ReviewDetailRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReviewDetailProvider._internal(
        (ref) => create(ref as ReviewDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reviewId: reviewId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Result<Review, BaseError>> createElement() {
    return _ReviewDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReviewDetailProvider && other.reviewId == reviewId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reviewId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReviewDetailRef
    on AutoDisposeFutureProviderRef<Result<Review, BaseError>> {
  /// The parameter `reviewId` of this provider.
  int get reviewId;
}

class _ReviewDetailProviderElement
    extends AutoDisposeFutureProviderElement<Result<Review, BaseError>>
    with ReviewDetailRef {
  _ReviewDetailProviderElement(super.provider);

  @override
  int get reviewId => (origin as ReviewDetailProvider).reviewId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
