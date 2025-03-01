import 'package:freezed_annotation/freezed_annotation.dart';

part 'venue_detail.g.dart';

part 'venue_detail.freezed.dart';

@freezed
class VenueDetail with _$VenueDetail {
  factory VenueDetail({
    @JsonKey(name: 'sections') required List<String> sections,
    @Default("") @JsonKey(name: 'venue_url') String seatmapUrl,
    @JsonKey(name: 'stages') required List<Stage> location,
    @JsonKey(name: 'venue_review_infos') required List<SectionReviewCount> sectionReviewCount,
  }) = _VenueDetail;

  factory VenueDetail.fromJson(Map<String, dynamic> json) => _$VenueDetailFromJson(json);
}

@freezed
class Stage with _$Stage {
  const factory Stage({
    @JsonKey(name: 'stage_id') required String stageId,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'svg_url') required String url,
  }) = _Stage;

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
}

@freezed
class SectionReviewCount with _$SectionReviewCount {
  const factory SectionReviewCount({
    @JsonKey(name: 'section_key') required String sectionKey,
    @JsonKey(name: 'review_cnt') required int reviewCount,
  }) = _SectionReviewCount;

  factory SectionReviewCount.fromJson(Map<String, dynamic> json) => _$SectionReviewCountFromJson(json);
}

extension SectionReviewCountX on VenueDetail {
  Map<String, int> get sectionReviewCountMap => Map.fromIterables(
      sectionReviewCount.map((section) => section.sectionKey), sectionReviewCount.map((section) => section.reviewCount));
}
