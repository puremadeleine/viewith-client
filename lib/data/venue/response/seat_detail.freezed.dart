// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SectionInfo _$SectionInfoFromJson(Map<String, dynamic> json) {
  return _SectionInfo.fromJson(json);
}

/// @nodoc
mixin _$SectionInfo {
  String get section => throw _privateConstructorUsedError;
  List<RowInfo> get rows => throw _privateConstructorUsedError;

  /// Serializes this SectionInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectionInfoCopyWith<SectionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionInfoCopyWith<$Res> {
  factory $SectionInfoCopyWith(
          SectionInfo value, $Res Function(SectionInfo) then) =
      _$SectionInfoCopyWithImpl<$Res, SectionInfo>;
  @useResult
  $Res call({String section, List<RowInfo> rows});
}

/// @nodoc
class _$SectionInfoCopyWithImpl<$Res, $Val extends SectionInfo>
    implements $SectionInfoCopyWith<$Res> {
  _$SectionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? section = null,
    Object? rows = null,
  }) {
    return _then(_value.copyWith(
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<RowInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionInfoImplCopyWith<$Res>
    implements $SectionInfoCopyWith<$Res> {
  factory _$$SectionInfoImplCopyWith(
          _$SectionInfoImpl value, $Res Function(_$SectionInfoImpl) then) =
      __$$SectionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String section, List<RowInfo> rows});
}

/// @nodoc
class __$$SectionInfoImplCopyWithImpl<$Res>
    extends _$SectionInfoCopyWithImpl<$Res, _$SectionInfoImpl>
    implements _$$SectionInfoImplCopyWith<$Res> {
  __$$SectionInfoImplCopyWithImpl(
      _$SectionInfoImpl _value, $Res Function(_$SectionInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of SectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? section = null,
    Object? rows = null,
  }) {
    return _then(_$SectionInfoImpl(
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<RowInfo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionInfoImpl implements _SectionInfo {
  const _$SectionInfoImpl(
      {required this.section, required final List<RowInfo> rows})
      : _rows = rows;

  factory _$SectionInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionInfoImplFromJson(json);

  @override
  final String section;
  final List<RowInfo> _rows;
  @override
  List<RowInfo> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  String toString() {
    return 'SectionInfo(section: $section, rows: $rows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionInfoImpl &&
            (identical(other.section, section) || other.section == section) &&
            const DeepCollectionEquality().equals(other._rows, _rows));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, section, const DeepCollectionEquality().hash(_rows));

  /// Create a copy of SectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionInfoImplCopyWith<_$SectionInfoImpl> get copyWith =>
      __$$SectionInfoImplCopyWithImpl<_$SectionInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionInfoImplToJson(
      this,
    );
  }
}

abstract class _SectionInfo implements SectionInfo {
  const factory _SectionInfo(
      {required final String section,
      required final List<RowInfo> rows}) = _$SectionInfoImpl;

  factory _SectionInfo.fromJson(Map<String, dynamic> json) =
      _$SectionInfoImpl.fromJson;

  @override
  String get section;
  @override
  List<RowInfo> get rows;

  /// Create a copy of SectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectionInfoImplCopyWith<_$SectionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RowInfo _$RowInfoFromJson(Map<String, dynamic> json) {
  return _RowInfo.fromJson(json);
}

/// @nodoc
mixin _$RowInfo {
  String get row => throw _privateConstructorUsedError;
  List<ColumnInfo> get columns => throw _privateConstructorUsedError;

  /// Serializes this RowInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RowInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RowInfoCopyWith<RowInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RowInfoCopyWith<$Res> {
  factory $RowInfoCopyWith(RowInfo value, $Res Function(RowInfo) then) =
      _$RowInfoCopyWithImpl<$Res, RowInfo>;
  @useResult
  $Res call({String row, List<ColumnInfo> columns});
}

/// @nodoc
class _$RowInfoCopyWithImpl<$Res, $Val extends RowInfo>
    implements $RowInfoCopyWith<$Res> {
  _$RowInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RowInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? row = null,
    Object? columns = null,
  }) {
    return _then(_value.copyWith(
      row: null == row
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as String,
      columns: null == columns
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<ColumnInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RowInfoImplCopyWith<$Res> implements $RowInfoCopyWith<$Res> {
  factory _$$RowInfoImplCopyWith(
          _$RowInfoImpl value, $Res Function(_$RowInfoImpl) then) =
      __$$RowInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String row, List<ColumnInfo> columns});
}

/// @nodoc
class __$$RowInfoImplCopyWithImpl<$Res>
    extends _$RowInfoCopyWithImpl<$Res, _$RowInfoImpl>
    implements _$$RowInfoImplCopyWith<$Res> {
  __$$RowInfoImplCopyWithImpl(
      _$RowInfoImpl _value, $Res Function(_$RowInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of RowInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? row = null,
    Object? columns = null,
  }) {
    return _then(_$RowInfoImpl(
      row: null == row
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as String,
      columns: null == columns
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<ColumnInfo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RowInfoImpl implements _RowInfo {
  const _$RowInfoImpl(
      {required this.row, required final List<ColumnInfo> columns})
      : _columns = columns;

  factory _$RowInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RowInfoImplFromJson(json);

  @override
  final String row;
  final List<ColumnInfo> _columns;
  @override
  List<ColumnInfo> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  @override
  String toString() {
    return 'RowInfo(row: $row, columns: $columns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RowInfoImpl &&
            (identical(other.row, row) || other.row == row) &&
            const DeepCollectionEquality().equals(other._columns, _columns));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, row, const DeepCollectionEquality().hash(_columns));

  /// Create a copy of RowInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RowInfoImplCopyWith<_$RowInfoImpl> get copyWith =>
      __$$RowInfoImplCopyWithImpl<_$RowInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RowInfoImplToJson(
      this,
    );
  }
}

abstract class _RowInfo implements RowInfo {
  const factory _RowInfo(
      {required final String row,
      required final List<ColumnInfo> columns}) = _$RowInfoImpl;

  factory _RowInfo.fromJson(Map<String, dynamic> json) = _$RowInfoImpl.fromJson;

  @override
  String get row;
  @override
  List<ColumnInfo> get columns;

  /// Create a copy of RowInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RowInfoImplCopyWith<_$RowInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ColumnInfo _$ColumnInfoFromJson(Map<String, dynamic> json) {
  return _ColumnInfo.fromJson(json);
}

/// @nodoc
mixin _$ColumnInfo {
  String get column => throw _privateConstructorUsedError;
  String? get block => throw _privateConstructorUsedError;

  /// Serializes this ColumnInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ColumnInfoCopyWith<ColumnInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColumnInfoCopyWith<$Res> {
  factory $ColumnInfoCopyWith(
          ColumnInfo value, $Res Function(ColumnInfo) then) =
      _$ColumnInfoCopyWithImpl<$Res, ColumnInfo>;
  @useResult
  $Res call({String column, String? block});
}

/// @nodoc
class _$ColumnInfoCopyWithImpl<$Res, $Val extends ColumnInfo>
    implements $ColumnInfoCopyWith<$Res> {
  _$ColumnInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? column = null,
    Object? block = freezed,
  }) {
    return _then(_value.copyWith(
      column: null == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as String,
      block: freezed == block
          ? _value.block
          : block // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ColumnInfoImplCopyWith<$Res>
    implements $ColumnInfoCopyWith<$Res> {
  factory _$$ColumnInfoImplCopyWith(
          _$ColumnInfoImpl value, $Res Function(_$ColumnInfoImpl) then) =
      __$$ColumnInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String column, String? block});
}

/// @nodoc
class __$$ColumnInfoImplCopyWithImpl<$Res>
    extends _$ColumnInfoCopyWithImpl<$Res, _$ColumnInfoImpl>
    implements _$$ColumnInfoImplCopyWith<$Res> {
  __$$ColumnInfoImplCopyWithImpl(
      _$ColumnInfoImpl _value, $Res Function(_$ColumnInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? column = null,
    Object? block = freezed,
  }) {
    return _then(_$ColumnInfoImpl(
      column: null == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as String,
      block: freezed == block
          ? _value.block
          : block // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColumnInfoImpl implements _ColumnInfo {
  const _$ColumnInfoImpl({required this.column, this.block});

  factory _$ColumnInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColumnInfoImplFromJson(json);

  @override
  final String column;
  @override
  final String? block;

  @override
  String toString() {
    return 'ColumnInfo(column: $column, block: $block)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColumnInfoImpl &&
            (identical(other.column, column) || other.column == column) &&
            (identical(other.block, block) || other.block == block));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, column, block);

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ColumnInfoImplCopyWith<_$ColumnInfoImpl> get copyWith =>
      __$$ColumnInfoImplCopyWithImpl<_$ColumnInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColumnInfoImplToJson(
      this,
    );
  }
}

abstract class _ColumnInfo implements ColumnInfo {
  const factory _ColumnInfo(
      {required final String column, final String? block}) = _$ColumnInfoImpl;

  factory _ColumnInfo.fromJson(Map<String, dynamic> json) =
      _$ColumnInfoImpl.fromJson;

  @override
  String get column;
  @override
  String? get block;

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ColumnInfoImplCopyWith<_$ColumnInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
