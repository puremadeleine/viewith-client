// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PerformanceImpl _$$PerformanceImplFromJson(Map<String, dynamic> json) =>
    _$PerformanceImpl(
      name: json['performance_title'] as String,
      venueName: json['venue_name'] as String,
      startDate: const DateTimeConverter()
          .fromJson((json['performance_start_date'] as num).toInt()),
      endDate: const DateTimeConverter()
          .fromJson((json['performance_end_date'] as num).toInt()),
    );

Map<String, dynamic> _$$PerformanceImplToJson(_$PerformanceImpl instance) =>
    <String, dynamic>{
      'performance_title': instance.name,
      'venue_name': instance.venueName,
      'performance_start_date':
          const DateTimeConverter().toJson(instance.startDate),
      'performance_end_date':
          const DateTimeConverter().toJson(instance.endDate),
    };
