// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReviewListState {
  String get id => throw _privateConstructorUsedError;
  AsyncValue<VenueDetail> get venueInfo => throw _privateConstructorUsedError;
  AsyncValue<List<Review>> get reviews => throw _privateConstructorUsedError;
  ReviewSortType get sortType => throw _privateConstructorUsedError;
  AsyncValue<List<SeatInfo>> get seatInfo => throw _privateConstructorUsedError;
  String? get selectedSection => throw _privateConstructorUsedError;

  /// Create a copy of ReviewListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewListStateCopyWith<ReviewListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewListStateCopyWith<$Res> {
  factory $ReviewListStateCopyWith(
          ReviewListState value, $Res Function(ReviewListState) then) =
      _$ReviewListStateCopyWithImpl<$Res, ReviewListState>;
  @useResult
  $Res call(
      {String id,
      AsyncValue<VenueDetail> venueInfo,
      AsyncValue<List<Review>> reviews,
      ReviewSortType sortType,
      AsyncValue<List<SeatInfo>> seatInfo,
      String? selectedSection});
}

/// @nodoc
class _$ReviewListStateCopyWithImpl<$Res, $Val extends ReviewListState>
    implements $ReviewListStateCopyWith<$Res> {
  _$ReviewListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? venueInfo = null,
    Object? reviews = null,
    Object? sortType = null,
    Object? seatInfo = null,
    Object? selectedSection = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      venueInfo: null == venueInfo
          ? _value.venueInfo
          : venueInfo // ignore: cast_nullable_to_non_nullable
              as AsyncValue<VenueDetail>,
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Review>>,
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as ReviewSortType,
      seatInfo: null == seatInfo
          ? _value.seatInfo
          : seatInfo // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SeatInfo>>,
      selectedSection: freezed == selectedSection
          ? _value.selectedSection
          : selectedSection // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewListStateImplCopyWith<$Res>
    implements $ReviewListStateCopyWith<$Res> {
  factory _$$ReviewListStateImplCopyWith(_$ReviewListStateImpl value,
          $Res Function(_$ReviewListStateImpl) then) =
      __$$ReviewListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      AsyncValue<VenueDetail> venueInfo,
      AsyncValue<List<Review>> reviews,
      ReviewSortType sortType,
      AsyncValue<List<SeatInfo>> seatInfo,
      String? selectedSection});
}

/// @nodoc
class __$$ReviewListStateImplCopyWithImpl<$Res>
    extends _$ReviewListStateCopyWithImpl<$Res, _$ReviewListStateImpl>
    implements _$$ReviewListStateImplCopyWith<$Res> {
  __$$ReviewListStateImplCopyWithImpl(
      _$ReviewListStateImpl _value, $Res Function(_$ReviewListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? venueInfo = null,
    Object? reviews = null,
    Object? sortType = null,
    Object? seatInfo = null,
    Object? selectedSection = freezed,
  }) {
    return _then(_$ReviewListStateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      venueInfo: null == venueInfo
          ? _value.venueInfo
          : venueInfo // ignore: cast_nullable_to_non_nullable
              as AsyncValue<VenueDetail>,
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Review>>,
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as ReviewSortType,
      seatInfo: null == seatInfo
          ? _value.seatInfo
          : seatInfo // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SeatInfo>>,
      selectedSection: freezed == selectedSection
          ? _value.selectedSection
          : selectedSection // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ReviewListStateImpl implements _ReviewListState {
  _$ReviewListStateImpl(
      {required this.id,
      required this.venueInfo,
      required this.reviews,
      this.sortType = ReviewSortType.defaultSort,
      required this.seatInfo,
      this.selectedSection});

  @override
  final String id;
  @override
  final AsyncValue<VenueDetail> venueInfo;
  @override
  final AsyncValue<List<Review>> reviews;
  @override
  @JsonKey()
  final ReviewSortType sortType;
  @override
  final AsyncValue<List<SeatInfo>> seatInfo;
  @override
  final String? selectedSection;

  @override
  String toString() {
    return 'ReviewListState(id: $id, venueInfo: $venueInfo, reviews: $reviews, sortType: $sortType, seatInfo: $seatInfo, selectedSection: $selectedSection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewListStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.venueInfo, venueInfo) ||
                other.venueInfo == venueInfo) &&
            (identical(other.reviews, reviews) || other.reviews == reviews) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.seatInfo, seatInfo) ||
                other.seatInfo == seatInfo) &&
            (identical(other.selectedSection, selectedSection) ||
                other.selectedSection == selectedSection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, venueInfo, reviews, sortType, seatInfo, selectedSection);

  /// Create a copy of ReviewListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewListStateImplCopyWith<_$ReviewListStateImpl> get copyWith =>
      __$$ReviewListStateImplCopyWithImpl<_$ReviewListStateImpl>(
          this, _$identity);
}

abstract class _ReviewListState implements ReviewListState {
  factory _ReviewListState(
      {required final String id,
      required final AsyncValue<VenueDetail> venueInfo,
      required final AsyncValue<List<Review>> reviews,
      final ReviewSortType sortType,
      required final AsyncValue<List<SeatInfo>> seatInfo,
      final String? selectedSection}) = _$ReviewListStateImpl;

  @override
  String get id;
  @override
  AsyncValue<VenueDetail> get venueInfo;
  @override
  AsyncValue<List<Review>> get reviews;
  @override
  ReviewSortType get sortType;
  @override
  AsyncValue<List<SeatInfo>> get seatInfo;
  @override
  String? get selectedSection;

  /// Create a copy of ReviewListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewListStateImplCopyWith<_$ReviewListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
