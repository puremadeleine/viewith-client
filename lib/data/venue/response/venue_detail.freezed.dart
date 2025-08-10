// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VenueDetail _$VenueDetailFromJson(Map<String, dynamic> json) {
  return _VenueDetail.fromJson(json);
}

/// @nodoc
mixin _$VenueDetail {
  @JsonKey(name: 'sections')
  List<String> get sections => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_url')
  String get seatmapUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'stages')
  List<Stage> get stages => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_review_infos')
  List<SectionReviewCount> get sectionReviewCount =>
      throw _privateConstructorUsedError;

  /// Serializes this VenueDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VenueDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VenueDetailCopyWith<VenueDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VenueDetailCopyWith<$Res> {
  factory $VenueDetailCopyWith(
          VenueDetail value, $Res Function(VenueDetail) then) =
      _$VenueDetailCopyWithImpl<$Res, VenueDetail>;
  @useResult
  $Res call(
      {@JsonKey(name: 'sections') List<String> sections,
      @JsonKey(name: 'venue_url') String seatmapUrl,
      @JsonKey(name: 'stages') List<Stage> stages,
      @JsonKey(name: 'venue_review_infos')
      List<SectionReviewCount> sectionReviewCount});
}

/// @nodoc
class _$VenueDetailCopyWithImpl<$Res, $Val extends VenueDetail>
    implements $VenueDetailCopyWith<$Res> {
  _$VenueDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VenueDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sections = null,
    Object? seatmapUrl = null,
    Object? stages = null,
    Object? sectionReviewCount = null,
  }) {
    return _then(_value.copyWith(
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      seatmapUrl: null == seatmapUrl
          ? _value.seatmapUrl
          : seatmapUrl // ignore: cast_nullable_to_non_nullable
              as String,
      stages: null == stages
          ? _value.stages
          : stages // ignore: cast_nullable_to_non_nullable
              as List<Stage>,
      sectionReviewCount: null == sectionReviewCount
          ? _value.sectionReviewCount
          : sectionReviewCount // ignore: cast_nullable_to_non_nullable
              as List<SectionReviewCount>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VenueDetailImplCopyWith<$Res>
    implements $VenueDetailCopyWith<$Res> {
  factory _$$VenueDetailImplCopyWith(
          _$VenueDetailImpl value, $Res Function(_$VenueDetailImpl) then) =
      __$$VenueDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'sections') List<String> sections,
      @JsonKey(name: 'venue_url') String seatmapUrl,
      @JsonKey(name: 'stages') List<Stage> stages,
      @JsonKey(name: 'venue_review_infos')
      List<SectionReviewCount> sectionReviewCount});
}

/// @nodoc
class __$$VenueDetailImplCopyWithImpl<$Res>
    extends _$VenueDetailCopyWithImpl<$Res, _$VenueDetailImpl>
    implements _$$VenueDetailImplCopyWith<$Res> {
  __$$VenueDetailImplCopyWithImpl(
      _$VenueDetailImpl _value, $Res Function(_$VenueDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of VenueDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sections = null,
    Object? seatmapUrl = null,
    Object? stages = null,
    Object? sectionReviewCount = null,
  }) {
    return _then(_$VenueDetailImpl(
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      seatmapUrl: null == seatmapUrl
          ? _value.seatmapUrl
          : seatmapUrl // ignore: cast_nullable_to_non_nullable
              as String,
      stages: null == stages
          ? _value._stages
          : stages // ignore: cast_nullable_to_non_nullable
              as List<Stage>,
      sectionReviewCount: null == sectionReviewCount
          ? _value._sectionReviewCount
          : sectionReviewCount // ignore: cast_nullable_to_non_nullable
              as List<SectionReviewCount>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VenueDetailImpl implements _VenueDetail {
  _$VenueDetailImpl(
      {@JsonKey(name: 'sections') required final List<String> sections,
      @JsonKey(name: 'venue_url') this.seatmapUrl = "",
      @JsonKey(name: 'stages') required final List<Stage> stages,
      @JsonKey(name: 'venue_review_infos')
      required final List<SectionReviewCount> sectionReviewCount})
      : _sections = sections,
        _stages = stages,
        _sectionReviewCount = sectionReviewCount;

  factory _$VenueDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$VenueDetailImplFromJson(json);

  final List<String> _sections;
  @override
  @JsonKey(name: 'sections')
  List<String> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  @JsonKey(name: 'venue_url')
  final String seatmapUrl;
  final List<Stage> _stages;
  @override
  @JsonKey(name: 'stages')
  List<Stage> get stages {
    if (_stages is EqualUnmodifiableListView) return _stages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stages);
  }

  final List<SectionReviewCount> _sectionReviewCount;
  @override
  @JsonKey(name: 'venue_review_infos')
  List<SectionReviewCount> get sectionReviewCount {
    if (_sectionReviewCount is EqualUnmodifiableListView)
      return _sectionReviewCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sectionReviewCount);
  }

  @override
  String toString() {
    return 'VenueDetail(sections: $sections, seatmapUrl: $seatmapUrl, stages: $stages, sectionReviewCount: $sectionReviewCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VenueDetailImpl &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.seatmapUrl, seatmapUrl) ||
                other.seatmapUrl == seatmapUrl) &&
            const DeepCollectionEquality().equals(other._stages, _stages) &&
            const DeepCollectionEquality()
                .equals(other._sectionReviewCount, _sectionReviewCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sections),
      seatmapUrl,
      const DeepCollectionEquality().hash(_stages),
      const DeepCollectionEquality().hash(_sectionReviewCount));

  /// Create a copy of VenueDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VenueDetailImplCopyWith<_$VenueDetailImpl> get copyWith =>
      __$$VenueDetailImplCopyWithImpl<_$VenueDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VenueDetailImplToJson(
      this,
    );
  }
}

abstract class _VenueDetail implements VenueDetail {
  factory _VenueDetail(
          {@JsonKey(name: 'sections') required final List<String> sections,
          @JsonKey(name: 'venue_url') final String seatmapUrl,
          @JsonKey(name: 'stages') required final List<Stage> stages,
          @JsonKey(name: 'venue_review_infos')
          required final List<SectionReviewCount> sectionReviewCount}) =
      _$VenueDetailImpl;

  factory _VenueDetail.fromJson(Map<String, dynamic> json) =
      _$VenueDetailImpl.fromJson;

  @override
  @JsonKey(name: 'sections')
  List<String> get sections;
  @override
  @JsonKey(name: 'venue_url')
  String get seatmapUrl;
  @override
  @JsonKey(name: 'stages')
  List<Stage> get stages;
  @override
  @JsonKey(name: 'venue_review_infos')
  List<SectionReviewCount> get sectionReviewCount;

  /// Create a copy of VenueDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VenueDetailImplCopyWith<_$VenueDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Stage _$StageFromJson(Map<String, dynamic> json) {
  return _Stage.fromJson(json);
}

/// @nodoc
mixin _$Stage {
  @JsonKey(name: 'stage_id')
  int get stageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'svg_url')
  String get svgUrl => throw _privateConstructorUsedError;

  /// Serializes this Stage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Stage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StageCopyWith<Stage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StageCopyWith<$Res> {
  factory $StageCopyWith(Stage value, $Res Function(Stage) then) =
      _$StageCopyWithImpl<$Res, Stage>;
  @useResult
  $Res call(
      {@JsonKey(name: 'stage_id') int stageId,
      @JsonKey(name: 'type') String type,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'svg_url') String svgUrl});
}

/// @nodoc
class _$StageCopyWithImpl<$Res, $Val extends Stage>
    implements $StageCopyWith<$Res> {
  _$StageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Stage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stageId = null,
    Object? type = null,
    Object? name = null,
    Object? svgUrl = null,
  }) {
    return _then(_value.copyWith(
      stageId: null == stageId
          ? _value.stageId
          : stageId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      svgUrl: null == svgUrl
          ? _value.svgUrl
          : svgUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StageImplCopyWith<$Res> implements $StageCopyWith<$Res> {
  factory _$$StageImplCopyWith(
          _$StageImpl value, $Res Function(_$StageImpl) then) =
      __$$StageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'stage_id') int stageId,
      @JsonKey(name: 'type') String type,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'svg_url') String svgUrl});
}

/// @nodoc
class __$$StageImplCopyWithImpl<$Res>
    extends _$StageCopyWithImpl<$Res, _$StageImpl>
    implements _$$StageImplCopyWith<$Res> {
  __$$StageImplCopyWithImpl(
      _$StageImpl _value, $Res Function(_$StageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Stage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stageId = null,
    Object? type = null,
    Object? name = null,
    Object? svgUrl = null,
  }) {
    return _then(_$StageImpl(
      stageId: null == stageId
          ? _value.stageId
          : stageId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      svgUrl: null == svgUrl
          ? _value.svgUrl
          : svgUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StageImpl implements _Stage {
  const _$StageImpl(
      {@JsonKey(name: 'stage_id') required this.stageId,
      @JsonKey(name: 'type') required this.type,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'svg_url') required this.svgUrl});

  factory _$StageImpl.fromJson(Map<String, dynamic> json) =>
      _$$StageImplFromJson(json);

  @override
  @JsonKey(name: 'stage_id')
  final int stageId;
  @override
  @JsonKey(name: 'type')
  final String type;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'svg_url')
  final String svgUrl;

  @override
  String toString() {
    return 'Stage(stageId: $stageId, type: $type, name: $name, svgUrl: $svgUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StageImpl &&
            (identical(other.stageId, stageId) || other.stageId == stageId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.svgUrl, svgUrl) || other.svgUrl == svgUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, stageId, type, name, svgUrl);

  /// Create a copy of Stage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StageImplCopyWith<_$StageImpl> get copyWith =>
      __$$StageImplCopyWithImpl<_$StageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StageImplToJson(
      this,
    );
  }
}

abstract class _Stage implements Stage {
  const factory _Stage(
      {@JsonKey(name: 'stage_id') required final int stageId,
      @JsonKey(name: 'type') required final String type,
      @JsonKey(name: 'name') required final String name,
      @JsonKey(name: 'svg_url') required final String svgUrl}) = _$StageImpl;

  factory _Stage.fromJson(Map<String, dynamic> json) = _$StageImpl.fromJson;

  @override
  @JsonKey(name: 'stage_id')
  int get stageId;
  @override
  @JsonKey(name: 'type')
  String get type;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'svg_url')
  String get svgUrl;

  /// Create a copy of Stage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StageImplCopyWith<_$StageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SectionReviewCount _$SectionReviewCountFromJson(Map<String, dynamic> json) {
  return _SectionReviewCount.fromJson(json);
}

/// @nodoc
mixin _$SectionReviewCount {
  @JsonKey(name: 'section_key')
  String get sectionKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_cnt')
  int get reviewCount => throw _privateConstructorUsedError;

  /// Serializes this SectionReviewCount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SectionReviewCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectionReviewCountCopyWith<SectionReviewCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionReviewCountCopyWith<$Res> {
  factory $SectionReviewCountCopyWith(
          SectionReviewCount value, $Res Function(SectionReviewCount) then) =
      _$SectionReviewCountCopyWithImpl<$Res, SectionReviewCount>;
  @useResult
  $Res call(
      {@JsonKey(name: 'section_key') String sectionKey,
      @JsonKey(name: 'review_cnt') int reviewCount});
}

/// @nodoc
class _$SectionReviewCountCopyWithImpl<$Res, $Val extends SectionReviewCount>
    implements $SectionReviewCountCopyWith<$Res> {
  _$SectionReviewCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SectionReviewCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sectionKey = null,
    Object? reviewCount = null,
  }) {
    return _then(_value.copyWith(
      sectionKey: null == sectionKey
          ? _value.sectionKey
          : sectionKey // ignore: cast_nullable_to_non_nullable
              as String,
      reviewCount: null == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionReviewCountImplCopyWith<$Res>
    implements $SectionReviewCountCopyWith<$Res> {
  factory _$$SectionReviewCountImplCopyWith(_$SectionReviewCountImpl value,
          $Res Function(_$SectionReviewCountImpl) then) =
      __$$SectionReviewCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'section_key') String sectionKey,
      @JsonKey(name: 'review_cnt') int reviewCount});
}

/// @nodoc
class __$$SectionReviewCountImplCopyWithImpl<$Res>
    extends _$SectionReviewCountCopyWithImpl<$Res, _$SectionReviewCountImpl>
    implements _$$SectionReviewCountImplCopyWith<$Res> {
  __$$SectionReviewCountImplCopyWithImpl(_$SectionReviewCountImpl _value,
      $Res Function(_$SectionReviewCountImpl) _then)
      : super(_value, _then);

  /// Create a copy of SectionReviewCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sectionKey = null,
    Object? reviewCount = null,
  }) {
    return _then(_$SectionReviewCountImpl(
      sectionKey: null == sectionKey
          ? _value.sectionKey
          : sectionKey // ignore: cast_nullable_to_non_nullable
              as String,
      reviewCount: null == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionReviewCountImpl implements _SectionReviewCount {
  const _$SectionReviewCountImpl(
      {@JsonKey(name: 'section_key') required this.sectionKey,
      @JsonKey(name: 'review_cnt') required this.reviewCount});

  factory _$SectionReviewCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionReviewCountImplFromJson(json);

  @override
  @JsonKey(name: 'section_key')
  final String sectionKey;
  @override
  @JsonKey(name: 'review_cnt')
  final int reviewCount;

  @override
  String toString() {
    return 'SectionReviewCount(sectionKey: $sectionKey, reviewCount: $reviewCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionReviewCountImpl &&
            (identical(other.sectionKey, sectionKey) ||
                other.sectionKey == sectionKey) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sectionKey, reviewCount);

  /// Create a copy of SectionReviewCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionReviewCountImplCopyWith<_$SectionReviewCountImpl> get copyWith =>
      __$$SectionReviewCountImplCopyWithImpl<_$SectionReviewCountImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionReviewCountImplToJson(
      this,
    );
  }
}

abstract class _SectionReviewCount implements SectionReviewCount {
  const factory _SectionReviewCount(
          {@JsonKey(name: 'section_key') required final String sectionKey,
          @JsonKey(name: 'review_cnt') required final int reviewCount}) =
      _$SectionReviewCountImpl;

  factory _SectionReviewCount.fromJson(Map<String, dynamic> json) =
      _$SectionReviewCountImpl.fromJson;

  @override
  @JsonKey(name: 'section_key')
  String get sectionKey;
  @override
  @JsonKey(name: 'review_cnt')
  int get reviewCount;

  /// Create a copy of SectionReviewCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectionReviewCountImplCopyWith<_$SectionReviewCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
