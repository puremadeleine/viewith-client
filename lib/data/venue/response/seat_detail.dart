import 'package:freezed_annotation/freezed_annotation.dart';

part 'seat_detail.freezed.dart';
part 'seat_detail.g.dart';

@freezed
class SectionInfo with _$SectionInfo {
  const factory SectionInfo({
    required String section,
    required List<RowInfo> rows,
  }) = _SectionInfo;

  factory SectionInfo.fromJson(Map<String, dynamic> json) => _$SectionInfoFromJson(json);
}

@freezed
class RowInfo with _$RowInfo {
  const factory RowInfo({
    required String row,
    required List<ColumnInfo> columns,
  }) = _RowInfo;

  factory RowInfo.fromJson(Map<String, dynamic> json) => _$RowInfoFromJson(json);
}

@freezed
class ColumnInfo with _$ColumnInfo {
  const factory ColumnInfo({
    required String column,
    String? block,
  }) = _ColumnInfo;

  factory ColumnInfo.fromJson(Map<String, dynamic> json) => _$ColumnInfoFromJson(json);
}
