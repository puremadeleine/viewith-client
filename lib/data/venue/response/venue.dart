import 'package:freezed_annotation/freezed_annotation.dart';

part 'venue.freezed.dart';
part 'venue.g.dart';

@freezed
class Venue with _$Venue {
  const factory Venue({
    @JsonKey(name: 'venue_id') required int id,
    @JsonKey(name: 'venue_name') required String name,
    @JsonKey(name: 'venue_location') required String location,
    List<Performance>? performances,
  }) = _Venue;

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
}

@freezed
class Performance with _$Performance {
  const factory Performance({
    required String? artist,
    @JsonKey(name: 'image_url') required String imageUrl,
  }) = _Performance;

  factory Performance.fromJson(Map<String, dynamic> json) => _$PerformanceFromJson(json);
}
