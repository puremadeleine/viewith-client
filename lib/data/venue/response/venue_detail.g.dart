// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VenueDetailImpl _$$VenueDetailImplFromJson(Map<String, dynamic> json) =>
    _$VenueDetailImpl(
      sections:
          (json['sections'] as List<dynamic>).map((e) => e as String).toList(),
      seatmapUrl: json['venue_url'] as String? ?? "",
      location: (json['stages'] as List<dynamic>)
          .map((e) => Stage.fromJson(e as Map<String, dynamic>))
          .toList(),
      sectionReviewCount: (json['venue_review_infos'] as List<dynamic>)
          .map((e) => SectionReviewCount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VenueDetailImplToJson(_$VenueDetailImpl instance) =>
    <String, dynamic>{
      'sections': instance.sections,
      'venue_url': instance.seatmapUrl,
      'stages': instance.location,
      'venue_review_infos': instance.sectionReviewCount,
    };

_$StageImpl _$$StageImplFromJson(Map<String, dynamic> json) => _$StageImpl(
      stageId: (json['stage_id'] as num).toInt(),
      type: json['type'] as String,
      name: json['name'] as String,
      url: json['svg_url'] as String,
    );

Map<String, dynamic> _$$StageImplToJson(_$StageImpl instance) =>
    <String, dynamic>{
      'stage_id': instance.stageId,
      'type': instance.type,
      'name': instance.name,
      'svg_url': instance.url,
    };

_$SectionReviewCountImpl _$$SectionReviewCountImplFromJson(
        Map<String, dynamic> json) =>
    _$SectionReviewCountImpl(
      sectionKey: json['section_key'] as String,
      reviewCount: (json['review_cnt'] as num).toInt(),
    );

Map<String, dynamic> _$$SectionReviewCountImplToJson(
        _$SectionReviewCountImpl instance) =>
    <String, dynamic>{
      'section_key': instance.sectionKey,
      'review_cnt': instance.reviewCount,
    };
