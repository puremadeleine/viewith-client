import 'package:freezed_annotation/freezed_annotation.dart';

part 'seat_info.freezed.dart';
part 'seat_info.g.dart';

@freezed
class SeatInfo with _$SeatInfo {
  const factory SeatInfo({
    @JsonKey(name: 'floor') required String floor,
    @JsonKey(name: 'rows') required List<String> rows,
  }) = _SeatInfo;

  factory SeatInfo.fromJson(Map<String, dynamic> json) => _$SeatInfoFromJson(json);
}