import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_params.freezed.dart';
part 'review_params.g.dart';

@freezed
class ReviewParams with _$ReviewParams {
  const factory ReviewParams({
    @Default(1) int page,
    @Default(10) int size,
    @JsonKey(name: 'sort_type')
    @Default(ReviewSortType.latest) ReviewSortType sortType,
    String? floor,
    String? section,
    @JsonKey(name: 'seat_row')
    int? row,
    @JsonKey(name: 'is_summary')
    @Default(false) bool isSummary,
  }) = _ReviewParams;

  factory ReviewParams.fromJson(Map<String, dynamic> json) =>
      _$ReviewParamsFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum ReviewSortType {
  @JsonValue('DEFAULT')
  defaultSort,
  @JsonValue('LATEST')
  latest,
  @JsonValue('RATING')
  rating;

  String get type {
    switch (this) {
      case ReviewSortType.defaultSort:
        return "기본순";
      case ReviewSortType.latest:
        return "최신순";
      case ReviewSortType.rating:
        return "별점순";
    }
  }
}
