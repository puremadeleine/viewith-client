import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark_response.freezed.dart';
part 'bookmark_response.g.dart';


@freezed
class BookmarkResponse with _$BookmarkResponse {
  const factory BookmarkResponse({
    required int venueId,
    required String venueName,
    required List<Floor> bookmarkFloors,
  }) = _BookmarkInfo;

  factory BookmarkResponse.fromJson(Map<String, dynamic> json) => _$BookmarkResponseFromJson(json);
}

@freezed
class Floor with _$Floor {
  const factory Floor({
    required String bookmarkFloor,
    required List<BookmarkedSeat> bookmarkSeats,
  }) = _Floor;

  factory Floor.fromJson(Map<String, dynamic> json) => _$FloorFromJson(json);
}

@freezed
class BookmarkedSeat with _$BookmarkedSeat {
  const factory BookmarkedSeat({
    required int bookmarkId,
    String? bookmarkSection,
    int? bookmarkRow,
    DateTime? lastUpdateDate,
  }) = _BookmarkedSeat;

  factory BookmarkedSeat.fromJson(Map<String, dynamic> json) => _$BookmarkedSeatFromJson(json);
}
