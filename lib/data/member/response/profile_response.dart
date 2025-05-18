import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    @JsonKey(name: 'nickname') required String nickname,
    @JsonKey(name: 'written_reviews_count') required int writtenReviewsCount,
    @JsonKey(name: 'bookmarks_count') required int bookmarkCount,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);
}
