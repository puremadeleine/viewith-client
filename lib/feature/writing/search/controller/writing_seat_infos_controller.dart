import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/venue/response/seat_detail.dart';
import 'package:viewith/data/venue/response/venue_detail.dart';
import 'package:viewith/data/venue/venue_repository_providers.dart';

part 'writing_seat_infos_controller.g.dart';

@riverpod
class SeatSection extends _$SeatSection {
  @override
  String? build() => null;

  void updateSection(String section) {
    state = section;
  }
}

@riverpod
class SeatRow extends _$SeatRow {
  @override
  String? build() => null;

  void updateRow(String row) {
    state = row;
  }
}

@riverpod
class SeatNumber extends _$SeatNumber {
  @override
  String? build() => null;

  void updateNumber(String number) {
    state = number;
  }
}

@riverpod
class SeatBlock extends _$SeatBlock {
  @override
  String? build() => null;

  void updateBlock(String block) {
    state = block;
  }
}

class WritingSeatInfoScreenData {
  final List<SectionInfo> seatDetail;
  final VenueDetail venueDetail;

  WritingSeatInfoScreenData({required this.seatDetail, required this.venueDetail});
}

@riverpod
class SeatDetailController extends _$SeatDetailController {
  @override
  Future<WritingSeatInfoScreenData> build(String venueId) async {
    final repository = ref.read(venueRepositoryProvider);

    final seatDetailFuture = repository.fetchSeatDetail(venueId);
    final venueDetailFuture = repository.fetchVenue(venueId);

    final results = await Future.wait([seatDetailFuture, venueDetailFuture]);

    final seatDetailResult = results[0] as Result<List<SectionInfo>, dynamic>;
    final venueDetailResult = results[1] as Result<VenueDetail, dynamic>;

    final seatDetail = seatDetailResult.match(
      onSuccess: (data) => data,
      onFailure: (error) => throw error,
    );
    final venueDetail = venueDetailResult.match(
      onSuccess: (data) => data,
      onFailure: (error) => throw error,
    );
    return WritingSeatInfoScreenData(seatDetail: seatDetail, venueDetail: venueDetail);
  }
}

@riverpod
class WritingSeatInfosController extends _$WritingSeatInfosController {
  @override
  Map<String, String?> build() {
    return {
      'section': null,
      'row': null,
      'number': null,
      'block': null,
    };
  }

  void updateSeatInfo({
    String? section,
    String? row,
    String? number,
    String? block,
  }) {
    state = {
      'section': section ?? state['section'],
      'row': row ?? state['row'],
      'number': number ?? state['number'],
      'block': block ?? state['block'],
    };
  }

  void setError(bool hasError) {
    if (hasError) {
      state = {
        ...state,
        'error': 'true',
      };
    } else {
      state = {
        'section': state['section'],
        'row': state['row'],
        'number': state['number'],
        'block': state['block'],
      };
    }
  }

  bool isValid() {
    return state['section'] != null && state['row'] != null && state['number'] != null;
  }
}

@riverpod
class WritingSeatInfosError extends _$WritingSeatInfosError {
  @override
  bool build() => false;

  void setError(bool hasError) {
    state = hasError;
  }
}
