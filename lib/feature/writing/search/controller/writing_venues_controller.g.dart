// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'writing_venues_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchQueryHash() => r'e648613e33797a57d9e4b8f7bb16e5c55ebd750e';

/// See also [SearchQuery].
@ProviderFor(SearchQuery)
final searchQueryProvider =
    AutoDisposeNotifierProvider<SearchQuery, String>.internal(
  SearchQuery.new,
  name: r'searchQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchQuery = AutoDisposeNotifier<String>;
String _$selectedVenueHash() => r'1c9e231d2a6c63fae4d4a0841dd72e1cd3da6d23';

/// See also [SelectedVenue].
@ProviderFor(SelectedVenue)
final selectedVenueProvider = NotifierProvider<SelectedVenue, Venue?>.internal(
  SelectedVenue.new,
  name: r'selectedVenueProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedVenueHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedVenue = Notifier<Venue?>;
String _$writingVenuesControllerHash() =>
    r'ac7309d00f7d3a30fbf568a2861957ac4e7ef2c4';

/// See also [WritingVenuesController].
@ProviderFor(WritingVenuesController)
final writingVenuesControllerProvider =
    AutoDisposeNotifierProvider<WritingVenuesController, List<Venue>>.internal(
  WritingVenuesController.new,
  name: r'writingVenuesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$writingVenuesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WritingVenuesController = AutoDisposeNotifier<List<Venue>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
