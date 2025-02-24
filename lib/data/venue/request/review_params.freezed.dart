// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReviewParams _$ReviewParamsFromJson(Map<String, dynamic> json) {
  return _ReviewParams.fromJson(json);
}

/// @nodoc
mixin _$ReviewParams {
  int get page => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_type')
  ReviewSortType get sortType => throw _privateConstructorUsedError;
  String? get floor => throw _privateConstructorUsedError;
  String? get section => throw _privateConstructorUsedError;
  @JsonKey(name: 'seat_row')
  int? get row => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_summary')
  bool get isSummary => throw _privateConstructorUsedError;

  /// Serializes this ReviewParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewParamsCopyWith<ReviewParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewParamsCopyWith<$Res> {
  factory $ReviewParamsCopyWith(
          ReviewParams value, $Res Function(ReviewParams) then) =
      _$ReviewParamsCopyWithImpl<$Res, ReviewParams>;
  @useResult
  $Res call(
      {int page,
      int size,
      @JsonKey(name: 'sort_type') ReviewSortType sortType,
      String? floor,
      String? section,
      @JsonKey(name: 'seat_row') int? row,
      @JsonKey(name: 'is_summary') bool isSummary});
}

/// @nodoc
class _$ReviewParamsCopyWithImpl<$Res, $Val extends ReviewParams>
    implements $ReviewParamsCopyWith<$Res> {
  _$ReviewParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? size = null,
    Object? sortType = null,
    Object? floor = freezed,
    Object? section = freezed,
    Object? row = freezed,
    Object? isSummary = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as ReviewSortType,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      row: freezed == row
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as int?,
      isSummary: null == isSummary
          ? _value.isSummary
          : isSummary // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewParamsImplCopyWith<$Res>
    implements $ReviewParamsCopyWith<$Res> {
  factory _$$ReviewParamsImplCopyWith(
          _$ReviewParamsImpl value, $Res Function(_$ReviewParamsImpl) then) =
      __$$ReviewParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      int size,
      @JsonKey(name: 'sort_type') ReviewSortType sortType,
      String? floor,
      String? section,
      @JsonKey(name: 'seat_row') int? row,
      @JsonKey(name: 'is_summary') bool isSummary});
}

/// @nodoc
class __$$ReviewParamsImplCopyWithImpl<$Res>
    extends _$ReviewParamsCopyWithImpl<$Res, _$ReviewParamsImpl>
    implements _$$ReviewParamsImplCopyWith<$Res> {
  __$$ReviewParamsImplCopyWithImpl(
      _$ReviewParamsImpl _value, $Res Function(_$ReviewParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? size = null,
    Object? sortType = null,
    Object? floor = freezed,
    Object? section = freezed,
    Object? row = freezed,
    Object? isSummary = null,
  }) {
    return _then(_$ReviewParamsImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as ReviewSortType,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      row: freezed == row
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as int?,
      isSummary: null == isSummary
          ? _value.isSummary
          : isSummary // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewParamsImpl implements _ReviewParams {
  const _$ReviewParamsImpl(
      {this.page = 1,
      this.size = 10,
      @JsonKey(name: 'sort_type') this.sortType = ReviewSortType.latest,
      this.floor,
      this.section,
      @JsonKey(name: 'seat_row') this.row,
      @JsonKey(name: 'is_summary') this.isSummary = false});

  factory _$ReviewParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewParamsImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int size;
  @override
  @JsonKey(name: 'sort_type')
  final ReviewSortType sortType;
  @override
  final String? floor;
  @override
  final String? section;
  @override
  @JsonKey(name: 'seat_row')
  final int? row;
  @override
  @JsonKey(name: 'is_summary')
  final bool isSummary;

  @override
  String toString() {
    return 'ReviewParams(page: $page, size: $size, sortType: $sortType, floor: $floor, section: $section, row: $row, isSummary: $isSummary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewParamsImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.row, row) || other.row == row) &&
            (identical(other.isSummary, isSummary) ||
                other.isSummary == isSummary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, page, size, sortType, floor, section, row, isSummary);

  /// Create a copy of ReviewParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewParamsImplCopyWith<_$ReviewParamsImpl> get copyWith =>
      __$$ReviewParamsImplCopyWithImpl<_$ReviewParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewParamsImplToJson(
      this,
    );
  }
}

abstract class _ReviewParams implements ReviewParams {
  const factory _ReviewParams(
      {final int page,
      final int size,
      @JsonKey(name: 'sort_type') final ReviewSortType sortType,
      final String? floor,
      final String? section,
      @JsonKey(name: 'seat_row') final int? row,
      @JsonKey(name: 'is_summary') final bool isSummary}) = _$ReviewParamsImpl;

  factory _ReviewParams.fromJson(Map<String, dynamic> json) =
      _$ReviewParamsImpl.fromJson;

  @override
  int get page;
  @override
  int get size;
  @override
  @JsonKey(name: 'sort_type')
  ReviewSortType get sortType;
  @override
  String? get floor;
  @override
  String? get section;
  @override
  @JsonKey(name: 'seat_row')
  int? get row;
  @override
  @JsonKey(name: 'is_summary')
  bool get isSummary;

  /// Create a copy of ReviewParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewParamsImplCopyWith<_$ReviewParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
