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

@Riverpod(keepAlive: true)
class SelectedVenue extends _$SelectedVenue {
  Venue? _venue;

  @override
  Venue? build() {
    return _venue;
  }

  void select(Venue? venue) {
    _venue = venue;
    state = venue;
    print("Venue selected and stored: $_venue");
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
        state = venues;
        return venues;
      },
      onFailure: (error) => throw error,
    );
  }
}
