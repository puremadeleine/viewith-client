import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark_response.freezed.dart';
part 'bookmark_response.g.dart';

@freezed
class BookmarkListResponse with _$BookmarkListResponse {
  const factory BookmarkListResponse({
    @JsonKey(name: 'bookmarks') required List<BookmarkResponse> bookmarks,
  }) = _BookmarkListResponse;

  factory BookmarkListResponse.fromJson(Map<String, dynamic> json) => _$BookmarkListResponseFromJson(json);
}

@freezed
class BookmarkResponse with _$BookmarkResponse {
  const factory BookmarkResponse({
    @JsonKey(name: 'venue_id') required int venueId,
    @JsonKey(name: 'venue_name') required String venueName,
    @JsonKey(name: 'bookmark_floors') required List<Floor> bookmarkFloors,
  }) = _BookmarkResponse;

  factory BookmarkResponse.fromJson(Map<String, dynamic> json) => _$BookmarkResponseFromJson(json);
}

@freezed
class Floor with _$Floor {
  const factory Floor({
    @JsonKey(name: 'bookmark_floor') required String bookmarkFloor,
    @JsonKey(name: 'bookmark_seats') required List<BookmarkedSeat> bookmarkSeats,
  }) = _Floor;

  factory Floor.fromJson(Map<String, dynamic> json) => _$FloorFromJson(json);
}

@freezed
class BookmarkedSeat with _$BookmarkedSeat {
  const factory BookmarkedSeat({
    @JsonKey(name: 'bookmark_id') required int bookmarkId,
    @JsonKey(name: 'bookmark_section') String? bookmarkSection,
    @JsonKey(name: 'bookmark_row') int? bookmarkRow,
    @JsonKey(name: 'last_update_date') DateTime? lastUpdateDate,
  }) = _BookmarkedSeat;

  factory BookmarkedSeat.fromJson(Map<String, dynamic> json) => _$BookmarkedSeatFromJson(json);
}
