// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookmarkResponse _$BookmarkResponseFromJson(Map<String, dynamic> json) {
  return _BookmarkInfo.fromJson(json);
}

/// @nodoc
mixin _$BookmarkResponse {
  int get venueId => throw _privateConstructorUsedError;
  String get venueName => throw _privateConstructorUsedError;
  List<Floor> get bookmarkFloors => throw _privateConstructorUsedError;

  /// Serializes this BookmarkResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookmarkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookmarkResponseCopyWith<BookmarkResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkResponseCopyWith<$Res> {
  factory $BookmarkResponseCopyWith(
          BookmarkResponse value, $Res Function(BookmarkResponse) then) =
      _$BookmarkResponseCopyWithImpl<$Res, BookmarkResponse>;
  @useResult
  $Res call({int venueId, String venueName, List<Floor> bookmarkFloors});
}

/// @nodoc
class _$BookmarkResponseCopyWithImpl<$Res, $Val extends BookmarkResponse>
    implements $BookmarkResponseCopyWith<$Res> {
  _$BookmarkResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookmarkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? venueId = null,
    Object? venueName = null,
    Object? bookmarkFloors = null,
  }) {
    return _then(_value.copyWith(
      venueId: null == venueId
          ? _value.venueId
          : venueId // ignore: cast_nullable_to_non_nullable
              as int,
      venueName: null == venueName
          ? _value.venueName
          : venueName // ignore: cast_nullable_to_non_nullable
              as String,
      bookmarkFloors: null == bookmarkFloors
          ? _value.bookmarkFloors
          : bookmarkFloors // ignore: cast_nullable_to_non_nullable
              as List<Floor>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookmarkInfoImplCopyWith<$Res>
    implements $BookmarkResponseCopyWith<$Res> {
  factory _$$BookmarkInfoImplCopyWith(
          _$BookmarkInfoImpl value, $Res Function(_$BookmarkInfoImpl) then) =
      __$$BookmarkInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int venueId, String venueName, List<Floor> bookmarkFloors});
}

/// @nodoc
class __$$BookmarkInfoImplCopyWithImpl<$Res>
    extends _$BookmarkResponseCopyWithImpl<$Res, _$BookmarkInfoImpl>
    implements _$$BookmarkInfoImplCopyWith<$Res> {
  __$$BookmarkInfoImplCopyWithImpl(
      _$BookmarkInfoImpl _value, $Res Function(_$BookmarkInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookmarkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? venueId = null,
    Object? venueName = null,
    Object? bookmarkFloors = null,
  }) {
    return _then(_$BookmarkInfoImpl(
      venueId: null == venueId
          ? _value.venueId
          : venueId // ignore: cast_nullable_to_non_nullable
              as int,
      venueName: null == venueName
          ? _value.venueName
          : venueName // ignore: cast_nullable_to_non_nullable
              as String,
      bookmarkFloors: null == bookmarkFloors
          ? _value._bookmarkFloors
          : bookmarkFloors // ignore: cast_nullable_to_non_nullable
              as List<Floor>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookmarkInfoImpl implements _BookmarkInfo {
  const _$BookmarkInfoImpl(
      {required this.venueId,
      required this.venueName,
      required final List<Floor> bookmarkFloors})
      : _bookmarkFloors = bookmarkFloors;

  factory _$BookmarkInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookmarkInfoImplFromJson(json);

  @override
  final int venueId;
  @override
  final String venueName;
  final List<Floor> _bookmarkFloors;
  @override
  List<Floor> get bookmarkFloors {
    if (_bookmarkFloors is EqualUnmodifiableListView) return _bookmarkFloors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookmarkFloors);
  }

  @override
  String toString() {
    return 'BookmarkResponse(venueId: $venueId, venueName: $venueName, bookmarkFloors: $bookmarkFloors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarkInfoImpl &&
            (identical(other.venueId, venueId) || other.venueId == venueId) &&
            (identical(other.venueName, venueName) ||
                other.venueName == venueName) &&
            const DeepCollectionEquality()
                .equals(other._bookmarkFloors, _bookmarkFloors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, venueId, venueName,
      const DeepCollectionEquality().hash(_bookmarkFloors));

  /// Create a copy of BookmarkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarkInfoImplCopyWith<_$BookmarkInfoImpl> get copyWith =>
      __$$BookmarkInfoImplCopyWithImpl<_$BookmarkInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookmarkInfoImplToJson(
      this,
    );
  }
}

abstract class _BookmarkInfo implements BookmarkResponse {
  const factory _BookmarkInfo(
      {required final int venueId,
      required final String venueName,
      required final List<Floor> bookmarkFloors}) = _$BookmarkInfoImpl;

  factory _BookmarkInfo.fromJson(Map<String, dynamic> json) =
      _$BookmarkInfoImpl.fromJson;

  @override
  int get venueId;
  @override
  String get venueName;
  @override
  List<Floor> get bookmarkFloors;

  /// Create a copy of BookmarkResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookmarkInfoImplCopyWith<_$BookmarkInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Floor _$FloorFromJson(Map<String, dynamic> json) {
  return _Floor.fromJson(json);
}

/// @nodoc
mixin _$Floor {
  String get bookmarkFloor => throw _privateConstructorUsedError;
  List<BookmarkedSeat> get bookmarkSeats => throw _privateConstructorUsedError;

  /// Serializes this Floor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Floor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FloorCopyWith<Floor> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloorCopyWith<$Res> {
  factory $FloorCopyWith(Floor value, $Res Function(Floor) then) =
      _$FloorCopyWithImpl<$Res, Floor>;
  @useResult
  $Res call({String bookmarkFloor, List<BookmarkedSeat> bookmarkSeats});
}

/// @nodoc
class _$FloorCopyWithImpl<$Res, $Val extends Floor>
    implements $FloorCopyWith<$Res> {
  _$FloorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Floor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookmarkFloor = null,
    Object? bookmarkSeats = null,
  }) {
    return _then(_value.copyWith(
      bookmarkFloor: null == bookmarkFloor
          ? _value.bookmarkFloor
          : bookmarkFloor // ignore: cast_nullable_to_non_nullable
              as String,
      bookmarkSeats: null == bookmarkSeats
          ? _value.bookmarkSeats
          : bookmarkSeats // ignore: cast_nullable_to_non_nullable
              as List<BookmarkedSeat>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FloorImplCopyWith<$Res> implements $FloorCopyWith<$Res> {
  factory _$$FloorImplCopyWith(
          _$FloorImpl value, $Res Function(_$FloorImpl) then) =
      __$$FloorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String bookmarkFloor, List<BookmarkedSeat> bookmarkSeats});
}

/// @nodoc
class __$$FloorImplCopyWithImpl<$Res>
    extends _$FloorCopyWithImpl<$Res, _$FloorImpl>
    implements _$$FloorImplCopyWith<$Res> {
  __$$FloorImplCopyWithImpl(
      _$FloorImpl _value, $Res Function(_$FloorImpl) _then)
      : super(_value, _then);

  /// Create a copy of Floor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookmarkFloor = null,
    Object? bookmarkSeats = null,
  }) {
    return _then(_$FloorImpl(
      bookmarkFloor: null == bookmarkFloor
          ? _value.bookmarkFloor
          : bookmarkFloor // ignore: cast_nullable_to_non_nullable
              as String,
      bookmarkSeats: null == bookmarkSeats
          ? _value._bookmarkSeats
          : bookmarkSeats // ignore: cast_nullable_to_non_nullable
              as List<BookmarkedSeat>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FloorImpl implements _Floor {
  const _$FloorImpl(
      {required this.bookmarkFloor,
      required final List<BookmarkedSeat> bookmarkSeats})
      : _bookmarkSeats = bookmarkSeats;

  factory _$FloorImpl.fromJson(Map<String, dynamic> json) =>
      _$$FloorImplFromJson(json);

  @override
  final String bookmarkFloor;
  final List<BookmarkedSeat> _bookmarkSeats;
  @override
  List<BookmarkedSeat> get bookmarkSeats {
    if (_bookmarkSeats is EqualUnmodifiableListView) return _bookmarkSeats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookmarkSeats);
  }

  @override
  String toString() {
    return 'Floor(bookmarkFloor: $bookmarkFloor, bookmarkSeats: $bookmarkSeats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FloorImpl &&
            (identical(other.bookmarkFloor, bookmarkFloor) ||
                other.bookmarkFloor == bookmarkFloor) &&
            const DeepCollectionEquality()
                .equals(other._bookmarkSeats, _bookmarkSeats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bookmarkFloor,
      const DeepCollectionEquality().hash(_bookmarkSeats));

  /// Create a copy of Floor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FloorImplCopyWith<_$FloorImpl> get copyWith =>
      __$$FloorImplCopyWithImpl<_$FloorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FloorImplToJson(
      this,
    );
  }
}

abstract class _Floor implements Floor {
  const factory _Floor(
      {required final String bookmarkFloor,
      required final List<BookmarkedSeat> bookmarkSeats}) = _$FloorImpl;

  factory _Floor.fromJson(Map<String, dynamic> json) = _$FloorImpl.fromJson;

  @override
  String get bookmarkFloor;
  @override
  List<BookmarkedSeat> get bookmarkSeats;

  /// Create a copy of Floor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FloorImplCopyWith<_$FloorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookmarkedSeat _$BookmarkedSeatFromJson(Map<String, dynamic> json) {
  return _BookmarkedSeat.fromJson(json);
}

/// @nodoc
mixin _$BookmarkedSeat {
  int get bookmarkId => throw _privateConstructorUsedError;
  String? get bookmarkSection => throw _privateConstructorUsedError;
  int? get bookmarkRow => throw _privateConstructorUsedError;
  DateTime? get lastUpdateDate => throw _privateConstructorUsedError;

  /// Serializes this BookmarkedSeat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookmarkedSeat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookmarkedSeatCopyWith<BookmarkedSeat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkedSeatCopyWith<$Res> {
  factory $BookmarkedSeatCopyWith(
          BookmarkedSeat value, $Res Function(BookmarkedSeat) then) =
      _$BookmarkedSeatCopyWithImpl<$Res, BookmarkedSeat>;
  @useResult
  $Res call(
      {int bookmarkId,
      String? bookmarkSection,
      int? bookmarkRow,
      DateTime? lastUpdateDate});
}

/// @nodoc
class _$BookmarkedSeatCopyWithImpl<$Res, $Val extends BookmarkedSeat>
    implements $BookmarkedSeatCopyWith<$Res> {
  _$BookmarkedSeatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookmarkedSeat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookmarkId = null,
    Object? bookmarkSection = freezed,
    Object? bookmarkRow = freezed,
    Object? lastUpdateDate = freezed,
  }) {
    return _then(_value.copyWith(
      bookmarkId: null == bookmarkId
          ? _value.bookmarkId
          : bookmarkId // ignore: cast_nullable_to_non_nullable
              as int,
      bookmarkSection: freezed == bookmarkSection
          ? _value.bookmarkSection
          : bookmarkSection // ignore: cast_nullable_to_non_nullable
              as String?,
      bookmarkRow: freezed == bookmarkRow
          ? _value.bookmarkRow
          : bookmarkRow // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdateDate: freezed == lastUpdateDate
          ? _value.lastUpdateDate
          : lastUpdateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookmarkedSeatImplCopyWith<$Res>
    implements $BookmarkedSeatCopyWith<$Res> {
  factory _$$BookmarkedSeatImplCopyWith(_$BookmarkedSeatImpl value,
          $Res Function(_$BookmarkedSeatImpl) then) =
      __$$BookmarkedSeatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int bookmarkId,
      String? bookmarkSection,
      int? bookmarkRow,
      DateTime? lastUpdateDate});
}

/// @nodoc
class __$$BookmarkedSeatImplCopyWithImpl<$Res>
    extends _$BookmarkedSeatCopyWithImpl<$Res, _$BookmarkedSeatImpl>
    implements _$$BookmarkedSeatImplCopyWith<$Res> {
  __$$BookmarkedSeatImplCopyWithImpl(
      _$BookmarkedSeatImpl _value, $Res Function(_$BookmarkedSeatImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookmarkedSeat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookmarkId = null,
    Object? bookmarkSection = freezed,
    Object? bookmarkRow = freezed,
    Object? lastUpdateDate = freezed,
  }) {
    return _then(_$BookmarkedSeatImpl(
      bookmarkId: null == bookmarkId
          ? _value.bookmarkId
          : bookmarkId // ignore: cast_nullable_to_non_nullable
              as int,
      bookmarkSection: freezed == bookmarkSection
          ? _value.bookmarkSection
          : bookmarkSection // ignore: cast_nullable_to_non_nullable
              as String?,
      bookmarkRow: freezed == bookmarkRow
          ? _value.bookmarkRow
          : bookmarkRow // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdateDate: freezed == lastUpdateDate
          ? _value.lastUpdateDate
          : lastUpdateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookmarkedSeatImpl implements _BookmarkedSeat {
  const _$BookmarkedSeatImpl(
      {required this.bookmarkId,
      this.bookmarkSection,
      this.bookmarkRow,
      this.lastUpdateDate});

  factory _$BookmarkedSeatImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookmarkedSeatImplFromJson(json);

  @override
  final int bookmarkId;
  @override
  final String? bookmarkSection;
  @override
  final int? bookmarkRow;
  @override
  final DateTime? lastUpdateDate;

  @override
  String toString() {
    return 'BookmarkedSeat(bookmarkId: $bookmarkId, bookmarkSection: $bookmarkSection, bookmarkRow: $bookmarkRow, lastUpdateDate: $lastUpdateDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarkedSeatImpl &&
            (identical(other.bookmarkId, bookmarkId) ||
                other.bookmarkId == bookmarkId) &&
            (identical(other.bookmarkSection, bookmarkSection) ||
                other.bookmarkSection == bookmarkSection) &&
            (identical(other.bookmarkRow, bookmarkRow) ||
                other.bookmarkRow == bookmarkRow) &&
            (identical(other.lastUpdateDate, lastUpdateDate) ||
                other.lastUpdateDate == lastUpdateDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, bookmarkId, bookmarkSection, bookmarkRow, lastUpdateDate);

  /// Create a copy of BookmarkedSeat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarkedSeatImplCopyWith<_$BookmarkedSeatImpl> get copyWith =>
      __$$BookmarkedSeatImplCopyWithImpl<_$BookmarkedSeatImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookmarkedSeatImplToJson(
      this,
    );
  }
}

abstract class _BookmarkedSeat implements BookmarkedSeat {
  const factory _BookmarkedSeat(
      {required final int bookmarkId,
      final String? bookmarkSection,
      final int? bookmarkRow,
      final DateTime? lastUpdateDate}) = _$BookmarkedSeatImpl;

  factory _BookmarkedSeat.fromJson(Map<String, dynamic> json) =
      _$BookmarkedSeatImpl.fromJson;

  @override
  int get bookmarkId;
  @override
  String? get bookmarkSection;
  @override
  int? get bookmarkRow;
  @override
  DateTime? get lastUpdateDate;

  /// Create a copy of BookmarkedSeat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookmarkedSeatImplCopyWith<_$BookmarkedSeatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
