import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance.freezed.dart';
part 'performance.g.dart';

class DateTimeConverter implements JsonConverter<DateTime, int> {
  const DateTimeConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime dateTime) => dateTime.millisecondsSinceEpoch;
}

@freezed
class Performance with _$Performance {
  const factory Performance({
    @JsonKey(name: 'performance_title') required String name,
    @JsonKey(name: 'venue_name') required String venueName,
    @JsonKey(name: 'performance_start_date') @DateTimeConverter() required DateTime startDate,
    @JsonKey(name: 'performance_end_date') @DateTimeConverter() required DateTime endDate,
  }) = _Performance;

  factory Performance.fromJson(Map<String, dynamic> json) => _$PerformanceFromJson(json);
}
