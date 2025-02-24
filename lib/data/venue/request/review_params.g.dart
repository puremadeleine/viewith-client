// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewParamsImpl _$$ReviewParamsImplFromJson(Map<String, dynamic> json) =>
    _$ReviewParamsImpl(
      page: (json['page'] as num?)?.toInt() ?? 1,
      size: (json['size'] as num?)?.toInt() ?? 10,
      sortType:
          $enumDecodeNullable(_$ReviewSortTypeEnumMap, json['sort_type']) ??
              ReviewSortType.latest,
      floor: json['floor'] as String?,
      section: json['section'] as String?,
      row: (json['seat_row'] as num?)?.toInt(),
      isSummary: json['is_summary'] as bool? ?? false,
    );

Map<String, dynamic> _$$ReviewParamsImplToJson(_$ReviewParamsImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort_type': _$ReviewSortTypeEnumMap[instance.sortType]!,
      'floor': instance.floor,
      'section': instance.section,
      'seat_row': instance.row,
      'is_summary': instance.isSummary,
    };

const _$ReviewSortTypeEnumMap = {
  ReviewSortType.defaultSort: 'DEFAULT',
  ReviewSortType.latest: 'LATEST',
  ReviewSortType.rating: 'RATING',
};
