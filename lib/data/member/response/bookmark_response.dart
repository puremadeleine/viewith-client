import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark_response.freezed.dart';
part 'bookmark_response.g.dart';

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
    // 서버 응답: "bookmark_row": "B" 와 같이 문자열이므로 String? 으로 정의
    @JsonKey(name: 'bookmark_row') String? bookmarkRow,
    // 서버 응답: "last_update_date": 1764511533916 (epoch millis) 이므로 int? 로 정의
    @JsonKey(name: 'last_update_date') int? lastUpdateDate,
  }) = _BookmarkedSeat;

  factory BookmarkedSeat.fromJson(Map<String, dynamic> json) => _$BookmarkedSeatFromJson(json);
}
