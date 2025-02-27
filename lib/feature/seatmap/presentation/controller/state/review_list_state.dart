import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:viewith/data/venue/request/review_params.dart';
import 'package:viewith/data/venue/response/seat_info.dart';
import 'package:viewith/data/venue/response/venue_detail.dart';
import 'package:viewith/ui/widgets/chip_list.dart';

import '../../../../../data/venue/response/review.dart';

part 'review_list_state.freezed.dart';

@freezed
class ReviewListState with _$ReviewListState {
  factory ReviewListState({
    required String id,
    required AsyncValue<VenueDetail> venueInfo,
    required AsyncValue<List<Review>> reviews,
    @Default(ReviewSortType.defaultSort) ReviewSortType sortType,
    required AsyncValue<List<SeatInfo>> seatInfo,
    String? selectedFloor,
    String? selectedRow,
  }) = _ReviewListState;
}

extension ReviewListStateX on ReviewListState {
  Map<String, List<int>> get seats =>
      Map.fromIterables(
          seatInfo.value?.map((seat) => seat.floor) ?? [],
          seatInfo.value?.map((seat) => seat.rows) ?? []
      );

  List<FilterChipData> get filterChips {
    List<FilterChipData> chips = [];

    if (sortType != ReviewSortType.defaultSort) {
      chips.add(FilterChipData(
        label: sortType.name,
        type: FilterType.sort,
      ));
    }

    if (selectedFloor != null) {
      String seatLabel = selectedRow == null ? "$selectedFloor층" : "$selectedFloor층 $selectedRow열";
      chips.add(FilterChipData(
        label: seatLabel,
        type: FilterType.seat,
      ));
    }

    return chips;
  }
}