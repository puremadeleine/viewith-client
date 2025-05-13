// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Performance _$PerformanceFromJson(Map<String, dynamic> json) {
  return _Performance.fromJson(json);
}

/// @nodoc
mixin _$Performance {
  @JsonKey(name: 'performance_title')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_name')
  String get venueName => throw _privateConstructorUsedError;
  @JsonKey(name: 'performance_start_date')
  @DateTimeConverter()
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'performance_end_date')
  @DateTimeConverter()
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Serializes this Performance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Performance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PerformanceCopyWith<Performance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformanceCopyWith<$Res> {
  factory $PerformanceCopyWith(
          Performance value, $Res Function(Performance) then) =
      _$PerformanceCopyWithImpl<$Res, Performance>;
  @useResult
  $Res call(
      {@JsonKey(name: 'performance_title') String name,
      @JsonKey(name: 'venue_name') String venueName,
      @JsonKey(name: 'performance_start_date')
      @DateTimeConverter()
      DateTime startDate,
      @JsonKey(name: 'performance_end_date')
      @DateTimeConverter()
      DateTime endDate});
}

/// @nodoc
class _$PerformanceCopyWithImpl<$Res, $Val extends Performance>
    implements $PerformanceCopyWith<$Res> {
  _$PerformanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Performance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? venueName = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      venueName: null == venueName
          ? _value.venueName
          : venueName // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerformanceImplCopyWith<$Res>
    implements $PerformanceCopyWith<$Res> {
  factory _$$PerformanceImplCopyWith(
          _$PerformanceImpl value, $Res Function(_$PerformanceImpl) then) =
      __$$PerformanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'performance_title') String name,
      @JsonKey(name: 'venue_name') String venueName,
      @JsonKey(name: 'performance_start_date')
      @DateTimeConverter()
      DateTime startDate,
      @JsonKey(name: 'performance_end_date')
      @DateTimeConverter()
      DateTime endDate});
}

/// @nodoc
class __$$PerformanceImplCopyWithImpl<$Res>
    extends _$PerformanceCopyWithImpl<$Res, _$PerformanceImpl>
    implements _$$PerformanceImplCopyWith<$Res> {
  __$$PerformanceImplCopyWithImpl(
      _$PerformanceImpl _value, $Res Function(_$PerformanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Performance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? venueName = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$PerformanceImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      venueName: null == venueName
          ? _value.venueName
          : venueName // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerformanceImpl implements _Performance {
  const _$PerformanceImpl(
      {@JsonKey(name: 'performance_title') required this.name,
      @JsonKey(name: 'venue_name') required this.venueName,
      @JsonKey(name: 'performance_start_date')
      @DateTimeConverter()
      required this.startDate,
      @JsonKey(name: 'performance_end_date')
      @DateTimeConverter()
      required this.endDate});

  factory _$PerformanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerformanceImplFromJson(json);

  @override
  @JsonKey(name: 'performance_title')
  final String name;
  @override
  @JsonKey(name: 'venue_name')
  final String venueName;
  @override
  @JsonKey(name: 'performance_start_date')
  @DateTimeConverter()
  final DateTime startDate;
  @override
  @JsonKey(name: 'performance_end_date')
  @DateTimeConverter()
  final DateTime endDate;

  @override
  String toString() {
    return 'Performance(name: $name, venueName: $venueName, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.venueName, venueName) ||
                other.venueName == venueName) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, venueName, startDate, endDate);

  /// Create a copy of Performance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceImplCopyWith<_$PerformanceImpl> get copyWith =>
      __$$PerformanceImplCopyWithImpl<_$PerformanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerformanceImplToJson(
      this,
    );
  }
}

abstract class _Performance implements Performance {
  const factory _Performance(
      {@JsonKey(name: 'performance_title') required final String name,
      @JsonKey(name: 'venue_name') required final String venueName,
      @JsonKey(name: 'performance_start_date')
      @DateTimeConverter()
      required final DateTime startDate,
      @JsonKey(name: 'performance_end_date')
      @DateTimeConverter()
      required final DateTime endDate}) = _$PerformanceImpl;

  factory _Performance.fromJson(Map<String, dynamic> json) =
      _$PerformanceImpl.fromJson;

  @override
  @JsonKey(name: 'performance_title')
  String get name;
  @override
  @JsonKey(name: 'venue_name')
  String get venueName;
  @override
  @JsonKey(name: 'performance_start_date')
  @DateTimeConverter()
  DateTime get startDate;
  @override
  @JsonKey(name: 'performance_end_date')
  @DateTimeConverter()
  DateTime get endDate;

  /// Create a copy of Performance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceImplCopyWith<_$PerformanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
