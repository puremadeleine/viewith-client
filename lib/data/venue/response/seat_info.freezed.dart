// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SeatInfo _$SeatInfoFromJson(Map<String, dynamic> json) {
  return _SeatInfo.fromJson(json);
}

/// @nodoc
mixin _$SeatInfo {
  @JsonKey(name: 'floor')
  String get floor => throw _privateConstructorUsedError;
  @JsonKey(name: 'rows')
  List<String> get rows => throw _privateConstructorUsedError;

  /// Serializes this SeatInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeatInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeatInfoCopyWith<SeatInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatInfoCopyWith<$Res> {
  factory $SeatInfoCopyWith(SeatInfo value, $Res Function(SeatInfo) then) =
      _$SeatInfoCopyWithImpl<$Res, SeatInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'floor') String floor,
      @JsonKey(name: 'rows') List<String> rows});
}

/// @nodoc
class _$SeatInfoCopyWithImpl<$Res, $Val extends SeatInfo>
    implements $SeatInfoCopyWith<$Res> {
  _$SeatInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeatInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? floor = null,
    Object? rows = null,
  }) {
    return _then(_value.copyWith(
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeatInfoImplCopyWith<$Res>
    implements $SeatInfoCopyWith<$Res> {
  factory _$$SeatInfoImplCopyWith(
          _$SeatInfoImpl value, $Res Function(_$SeatInfoImpl) then) =
      __$$SeatInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'floor') String floor,
      @JsonKey(name: 'rows') List<String> rows});
}

/// @nodoc
class __$$SeatInfoImplCopyWithImpl<$Res>
    extends _$SeatInfoCopyWithImpl<$Res, _$SeatInfoImpl>
    implements _$$SeatInfoImplCopyWith<$Res> {
  __$$SeatInfoImplCopyWithImpl(
      _$SeatInfoImpl _value, $Res Function(_$SeatInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of SeatInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? floor = null,
    Object? rows = null,
  }) {
    return _then(_$SeatInfoImpl(
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String,
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeatInfoImpl implements _SeatInfo {
  const _$SeatInfoImpl(
      {@JsonKey(name: 'floor') required this.floor,
      @JsonKey(name: 'rows') required final List<String> rows})
      : _rows = rows;

  factory _$SeatInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatInfoImplFromJson(json);

  @override
  @JsonKey(name: 'floor')
  final String floor;
  final List<String> _rows;
  @override
  @JsonKey(name: 'rows')
  List<String> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  String toString() {
    return 'SeatInfo(floor: $floor, rows: $rows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatInfoImpl &&
            (identical(other.floor, floor) || other.floor == floor) &&
            const DeepCollectionEquality().equals(other._rows, _rows));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, floor, const DeepCollectionEquality().hash(_rows));

  /// Create a copy of SeatInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatInfoImplCopyWith<_$SeatInfoImpl> get copyWith =>
      __$$SeatInfoImplCopyWithImpl<_$SeatInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatInfoImplToJson(
      this,
    );
  }
}

abstract class _SeatInfo implements SeatInfo {
  const factory _SeatInfo(
          {@JsonKey(name: 'floor') required final String floor,
          @JsonKey(name: 'rows') required final List<String> rows}) =
      _$SeatInfoImpl;

  factory _SeatInfo.fromJson(Map<String, dynamic> json) =
      _$SeatInfoImpl.fromJson;

  @override
  @JsonKey(name: 'floor')
  String get floor;
  @override
  @JsonKey(name: 'rows')
  List<String> get rows;

  /// Create a copy of SeatInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeatInfoImplCopyWith<_$SeatInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
