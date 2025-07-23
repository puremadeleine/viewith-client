// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'writing_seat_infos_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$seatSectionHash() => r'3427b6a0ced233eb58c87f65fb489b915844d78c';

/// See also [SeatSection].
@ProviderFor(SeatSection)
final seatSectionProvider =
    AutoDisposeNotifierProvider<SeatSection, String?>.internal(
  SeatSection.new,
  name: r'seatSectionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$seatSectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SeatSection = AutoDisposeNotifier<String?>;
String _$seatRowHash() => r'c17a298389c5f01f389e442b942d25a5ce271974';

/// See also [SeatRow].
@ProviderFor(SeatRow)
final seatRowProvider = AutoDisposeNotifierProvider<SeatRow, String?>.internal(
  SeatRow.new,
  name: r'seatRowProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$seatRowHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SeatRow = AutoDisposeNotifier<String?>;
String _$seatNumberHash() => r'c084f1fba4a37dea15232c0d1898172c7104dd90';

/// See also [SeatNumber].
@ProviderFor(SeatNumber)
final seatNumberProvider =
    AutoDisposeNotifierProvider<SeatNumber, String?>.internal(
  SeatNumber.new,
  name: r'seatNumberProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$seatNumberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SeatNumber = AutoDisposeNotifier<String?>;
String _$seatBlockHash() => r'f47989f99c3ad14b0f969f2f821b2e7f1cc190da';

/// See also [SeatBlock].
@ProviderFor(SeatBlock)
final seatBlockProvider =
    AutoDisposeNotifierProvider<SeatBlock, String?>.internal(
  SeatBlock.new,
  name: r'seatBlockProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$seatBlockHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SeatBlock = AutoDisposeNotifier<String?>;
String _$seatDetailControllerHash() =>
    r'b0a80fbd2f753e1fa020757f03ef3dbee80f714c';

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

abstract class _$SeatDetailController
    extends BuildlessAutoDisposeAsyncNotifier<WritingSeatInfoScreenData> {
  late final String venueId;

  FutureOr<WritingSeatInfoScreenData> build(
    String venueId,
  );
}

/// See also [SeatDetailController].
@ProviderFor(SeatDetailController)
const seatDetailControllerProvider = SeatDetailControllerFamily();

/// See also [SeatDetailController].
class SeatDetailControllerFamily
    extends Family<AsyncValue<WritingSeatInfoScreenData>> {
  /// See also [SeatDetailController].
  const SeatDetailControllerFamily();

  /// See also [SeatDetailController].
  SeatDetailControllerProvider call(
    String venueId,
  ) {
    return SeatDetailControllerProvider(
      venueId,
    );
  }

  @override
  SeatDetailControllerProvider getProviderOverride(
    covariant SeatDetailControllerProvider provider,
  ) {
    return call(
      provider.venueId,
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
  String? get name => r'seatDetailControllerProvider';
}

/// See also [SeatDetailController].
class SeatDetailControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    SeatDetailController, WritingSeatInfoScreenData> {
  /// See also [SeatDetailController].
  SeatDetailControllerProvider(
    String venueId,
  ) : this._internal(
          () => SeatDetailController()..venueId = venueId,
          from: seatDetailControllerProvider,
          name: r'seatDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$seatDetailControllerHash,
          dependencies: SeatDetailControllerFamily._dependencies,
          allTransitiveDependencies:
              SeatDetailControllerFamily._allTransitiveDependencies,
          venueId: venueId,
        );

  SeatDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.venueId,
  }) : super.internal();

  final String venueId;

  @override
  FutureOr<WritingSeatInfoScreenData> runNotifierBuild(
    covariant SeatDetailController notifier,
  ) {
    return notifier.build(
      venueId,
    );
  }

  @override
  Override overrideWith(SeatDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SeatDetailControllerProvider._internal(
        () => create()..venueId = venueId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        venueId: venueId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SeatDetailController,
      WritingSeatInfoScreenData> createElement() {
    return _SeatDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SeatDetailControllerProvider && other.venueId == venueId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, venueId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SeatDetailControllerRef
    on AutoDisposeAsyncNotifierProviderRef<WritingSeatInfoScreenData> {
  /// The parameter `venueId` of this provider.
  String get venueId;
}

class _SeatDetailControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SeatDetailController,
        WritingSeatInfoScreenData> with SeatDetailControllerRef {
  _SeatDetailControllerProviderElement(super.provider);

  @override
  String get venueId => (origin as SeatDetailControllerProvider).venueId;
}

String _$writingSeatInfosControllerHash() =>
    r'ed3cfb87924cfe5bc740975fb5d19514bc7bd773';

/// See also [WritingSeatInfosController].
@ProviderFor(WritingSeatInfosController)
final writingSeatInfosControllerProvider = AutoDisposeNotifierProvider<
    WritingSeatInfosController, Map<String, String?>>.internal(
  WritingSeatInfosController.new,
  name: r'writingSeatInfosControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$writingSeatInfosControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WritingSeatInfosController
    = AutoDisposeNotifier<Map<String, String?>>;
String _$writingSeatInfosErrorHash() =>
    r'2780c5e33640f6171d6249dcc70377c8b9e19b1c';

/// See also [WritingSeatInfosError].
@ProviderFor(WritingSeatInfosError)
final writingSeatInfosErrorProvider =
    AutoDisposeNotifierProvider<WritingSeatInfosError, bool>.internal(
  WritingSeatInfosError.new,
  name: r'writingSeatInfosErrorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$writingSeatInfosErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WritingSeatInfosError = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
