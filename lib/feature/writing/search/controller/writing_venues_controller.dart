import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/venue/response/venue.dart';
import '../../../../data/venue/venue_repository_providers.dart';

part 'writing_venues_controller.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String newQuery) {
    state = newQuery;
  }
}

@riverpod
class SelectedVenue extends _$SelectedVenue {
  @override
  Venue? build() => null;

  void select(Venue? venue) {
    state = venue;
  }
}

@riverpod
class WritingVenuesController extends _$WritingVenuesController {
  @override
  List<Venue> build() {
    return [];
  }

  Future<List<Venue>> searchVenues(String keyword) async {
    final result = await ref.read(venueRepositoryProvider).searchVenues(keyword);
    return result.match(
      onSuccess: (venues) {
        print('searchVenues $venues');
        state = venues;
        return venues;
      },
      onFailure: (error) => throw error,
    );
  }
}
