// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_review_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReportReviewRequest _$ReportReviewRequestFromJson(Map<String, dynamic> json) {
  return _ReportReviewRequest.fromJson(json);
}

/// @nodoc
mixin _$ReportReviewRequest {
  @JsonKey(name: 'report_reason')
  String? get reportReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'report_reason_detail')
  String? get reportReasonDetail => throw _privateConstructorUsedError;

  /// Serializes this ReportReviewRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportReviewRequestCopyWith<ReportReviewRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportReviewRequestCopyWith<$Res> {
  factory $ReportReviewRequestCopyWith(
          ReportReviewRequest value, $Res Function(ReportReviewRequest) then) =
      _$ReportReviewRequestCopyWithImpl<$Res, ReportReviewRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'report_reason') String? reportReason,
      @JsonKey(name: 'report_reason_detail') String? reportReasonDetail});
}

/// @nodoc
class _$ReportReviewRequestCopyWithImpl<$Res, $Val extends ReportReviewRequest>
    implements $ReportReviewRequestCopyWith<$Res> {
  _$ReportReviewRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportReason = freezed,
    Object? reportReasonDetail = freezed,
  }) {
    return _then(_value.copyWith(
      reportReason: freezed == reportReason
          ? _value.reportReason
          : reportReason // ignore: cast_nullable_to_non_nullable
              as String?,
      reportReasonDetail: freezed == reportReasonDetail
          ? _value.reportReasonDetail
          : reportReasonDetail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportReviewRequestImplCopyWith<$Res>
    implements $ReportReviewRequestCopyWith<$Res> {
  factory _$$ReportReviewRequestImplCopyWith(_$ReportReviewRequestImpl value,
          $Res Function(_$ReportReviewRequestImpl) then) =
      __$$ReportReviewRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'report_reason') String? reportReason,
      @JsonKey(name: 'report_reason_detail') String? reportReasonDetail});
}

/// @nodoc
class __$$ReportReviewRequestImplCopyWithImpl<$Res>
    extends _$ReportReviewRequestCopyWithImpl<$Res, _$ReportReviewRequestImpl>
    implements _$$ReportReviewRequestImplCopyWith<$Res> {
  __$$ReportReviewRequestImplCopyWithImpl(_$ReportReviewRequestImpl _value,
      $Res Function(_$ReportReviewRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportReason = freezed,
    Object? reportReasonDetail = freezed,
  }) {
    return _then(_$ReportReviewRequestImpl(
      reportReason: freezed == reportReason
          ? _value.reportReason
          : reportReason // ignore: cast_nullable_to_non_nullable
              as String?,
      reportReasonDetail: freezed == reportReasonDetail
          ? _value.reportReasonDetail
          : reportReasonDetail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportReviewRequestImpl implements _ReportReviewRequest {
  const _$ReportReviewRequestImpl(
      {@JsonKey(name: 'report_reason') this.reportReason,
      @JsonKey(name: 'report_reason_detail') this.reportReasonDetail});

  factory _$ReportReviewRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportReviewRequestImplFromJson(json);

  @override
  @JsonKey(name: 'report_reason')
  final String? reportReason;
  @override
  @JsonKey(name: 'report_reason_detail')
  final String? reportReasonDetail;

  @override
  String toString() {
    return 'ReportReviewRequest(reportReason: $reportReason, reportReasonDetail: $reportReasonDetail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportReviewRequestImpl &&
            (identical(other.reportReason, reportReason) ||
                other.reportReason == reportReason) &&
            (identical(other.reportReasonDetail, reportReasonDetail) ||
                other.reportReasonDetail == reportReasonDetail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, reportReason, reportReasonDetail);

  /// Create a copy of ReportReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportReviewRequestImplCopyWith<_$ReportReviewRequestImpl> get copyWith =>
      __$$ReportReviewRequestImplCopyWithImpl<_$ReportReviewRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportReviewRequestImplToJson(
      this,
    );
  }
}

abstract class _ReportReviewRequest implements ReportReviewRequest {
  const factory _ReportReviewRequest(
      {@JsonKey(name: 'report_reason') final String? reportReason,
      @JsonKey(name: 'report_reason_detail')
      final String? reportReasonDetail}) = _$ReportReviewRequestImpl;

  factory _ReportReviewRequest.fromJson(Map<String, dynamic> json) =
      _$ReportReviewRequestImpl.fromJson;

  @override
  @JsonKey(name: 'report_reason')
  String? get reportReason;
  @override
  @JsonKey(name: 'report_reason_detail')
  String? get reportReasonDetail;

  /// Create a copy of ReportReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportReviewRequestImplCopyWith<_$ReportReviewRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
