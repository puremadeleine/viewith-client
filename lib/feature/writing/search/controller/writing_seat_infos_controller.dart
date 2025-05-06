import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/data/venue/response/seat_detail.dart';
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

@riverpod
class SeatDetailController extends _$SeatDetailController {
  @override
  Future<List<SectionInfo>> build(String venueId) async {
    final repository = ref.read(venueRepositoryProvider);
    final result = await repository.fetchSeatDetail(venueId);

    return result.match(
      onSuccess: (data) => data,
      onFailure: (error) => throw error,
    );
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

  bool isValid() {
    return state['section'] != null && state['row'] != null && state['number'] != null;
  }
}
