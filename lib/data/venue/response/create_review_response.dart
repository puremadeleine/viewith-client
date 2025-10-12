import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_review_response.freezed.dart';
part 'create_review_response.g.dart';

@freezed
class CreateReviewResponse with _$CreateReviewResponse {
  const factory CreateReviewResponse({
    @JsonKey(name: 'review_id') required int reviewId,
  }) = _CreateReviewResponse;

  factory CreateReviewResponse.fromJson(Map<String, dynamic> json) => 
      _$CreateReviewResponseFromJson(json);
}
