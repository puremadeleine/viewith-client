// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SectionInfoImpl _$$SectionInfoImplFromJson(Map<String, dynamic> json) =>
    _$SectionInfoImpl(
      section: json['section'] as String,
      rows: (json['rows'] as List<dynamic>)
          .map((e) => RowInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SectionInfoImplToJson(_$SectionInfoImpl instance) =>
    <String, dynamic>{
      'section': instance.section,
      'rows': instance.rows,
    };

_$RowInfoImpl _$$RowInfoImplFromJson(Map<String, dynamic> json) =>
    _$RowInfoImpl(
      row: (json['row'] as num).toInt(),
      columns: (json['columns'] as List<dynamic>)
          .map((e) => ColumnInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RowInfoImplToJson(_$RowInfoImpl instance) =>
    <String, dynamic>{
      'row': instance.row,
      'columns': instance.columns,
    };

_$ColumnInfoImpl _$$ColumnInfoImplFromJson(Map<String, dynamic> json) =>
    _$ColumnInfoImpl(
      column: (json['column'] as num).toInt(),
      block: json['block'] as String?,
    );

Map<String, dynamic> _$$ColumnInfoImplToJson(_$ColumnInfoImpl instance) =>
    <String, dynamic>{
      'column': instance.column,
      'block': instance.block,
    };
