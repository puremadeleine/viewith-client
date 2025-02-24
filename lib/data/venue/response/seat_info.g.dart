// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeatInfoImpl _$$SeatInfoImplFromJson(Map<String, dynamic> json) =>
    _$SeatInfoImpl(
      floor: json['floor'] as String,
      rows: (json['rows'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$SeatInfoImplToJson(_$SeatInfoImpl instance) =>
    <String, dynamic>{
      'floor': instance.floor,
      'rows': instance.rows,
    };
