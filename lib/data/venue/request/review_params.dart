import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_params.freezed.dart';
part 'review_params.g.dart';

@freezed
class ReviewParams with _$ReviewParams {
  const factory ReviewParams({
    @Default(1) int page,
    @Default(10) int size,

    @JsonKey(name: 'venue_id', includeIfNull: false)
    String? venueId,

    @JsonKey(name: 'sort_type')
    @Default(ReviewSortType.latest) ReviewSortType sortType,

    @JsonKey(name: 'floor', includeIfNull: false)
    @Default("1") String? floor,

    @JsonKey(name: 'section', includeIfNull: false)
    String? section,

    @JsonKey(name: 'seat_row', includeIfNull: false)
    String? row,

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

  String get name {
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
