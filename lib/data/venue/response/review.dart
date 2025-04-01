// review_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'review.freezed.dart';

part 'review.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    @JsonKey(name: 'review_id') required int reviewId,
    required String content,
    required double rating,
    @JsonKey(name: 'create_time') required int createTime,
    @JsonKey(name: 'image_list') required List<String> imageList,
    @JsonKey(name: 'user_info') required UserInfo userInfo,
    @JsonKey(name: 'seat_info') required SeatRawData seatRawData,
    @JsonKey(name: 'seat_bookmark_info') BookmarkData? bookmarkInfo,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_nickname') required String userNickname,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
}

@freezed
class SeatRawData with _$SeatRawData {
  const factory SeatRawData({
    @JsonKey(name: 'floor') required String floor,
    @JsonKey(name: 'section') required String section,
    @JsonKey(name: 'seat_row') required int row,
    @JsonKey(name: 'seat_column') required int column,
    @JsonKey(name: 'block') String? block,
  }) = _SeatRawData;

  factory SeatRawData.fromJson(Map<String, dynamic> json) => _$SeatRawDataFromJson(json);
}

@freezed
class BookmarkData with _$BookmarkData {
  const factory BookmarkData({
    @JsonKey(name: 'seat_id') required int seatId,
    @JsonKey(name: 'bookmarked') required bool bookmarked,
  }) = _BookmarkData;

  factory BookmarkData.fromJson(Map<String, dynamic> json) => _$BookmarkDataFromJson(json);
}

extension ReviewX on Review {
  String get createdAt {
    final createTime = this.createTime;
    if (createTime == null) return '';
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(createTime);
    String formattedDate = DateFormat('yyyy년 MM월 dd일').format(dateTime);
    return formattedDate;
  }

  String get seatName => '${seatRawData.section}구역 ${seatRawData.row}열 ${seatRawData.column}번';
}
