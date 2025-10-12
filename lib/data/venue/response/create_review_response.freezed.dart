// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_review_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateReviewResponse _$CreateReviewResponseFromJson(Map<String, dynamic> json) {
  return _CreateReviewResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateReviewResponse {
  @JsonKey(name: 'review_id')
  int get reviewId => throw _privateConstructorUsedError;

  /// Serializes this CreateReviewResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateReviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateReviewResponseCopyWith<CreateReviewResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateReviewResponseCopyWith<$Res> {
  factory $CreateReviewResponseCopyWith(CreateReviewResponse value,
          $Res Function(CreateReviewResponse) then) =
      _$CreateReviewResponseCopyWithImpl<$Res, CreateReviewResponse>;
  @useResult
  $Res call({@JsonKey(name: 'review_id') int reviewId});
}

/// @nodoc
class _$CreateReviewResponseCopyWithImpl<$Res,
        $Val extends CreateReviewResponse>
    implements $CreateReviewResponseCopyWith<$Res> {
  _$CreateReviewResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateReviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewId = null,
  }) {
    return _then(_value.copyWith(
      reviewId: null == reviewId
          ? _value.reviewId
          : reviewId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateReviewResponseImplCopyWith<$Res>
    implements $CreateReviewResponseCopyWith<$Res> {
  factory _$$CreateReviewResponseImplCopyWith(_$CreateReviewResponseImpl value,
          $Res Function(_$CreateReviewResponseImpl) then) =
      __$$CreateReviewResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'review_id') int reviewId});
}

/// @nodoc
class __$$CreateReviewResponseImplCopyWithImpl<$Res>
    extends _$CreateReviewResponseCopyWithImpl<$Res, _$CreateReviewResponseImpl>
    implements _$$CreateReviewResponseImplCopyWith<$Res> {
  __$$CreateReviewResponseImplCopyWithImpl(_$CreateReviewResponseImpl _value,
      $Res Function(_$CreateReviewResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateReviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewId = null,
  }) {
    return _then(_$CreateReviewResponseImpl(
      reviewId: null == reviewId
          ? _value.reviewId
          : reviewId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateReviewResponseImpl implements _CreateReviewResponse {
  const _$CreateReviewResponseImpl(
      {@JsonKey(name: 'review_id') required this.reviewId});

  factory _$CreateReviewResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateReviewResponseImplFromJson(json);

  @override
  @JsonKey(name: 'review_id')
  final int reviewId;

  @override
  String toString() {
    return 'CreateReviewResponse(reviewId: $reviewId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateReviewResponseImpl &&
            (identical(other.reviewId, reviewId) ||
                other.reviewId == reviewId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reviewId);

  /// Create a copy of CreateReviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateReviewResponseImplCopyWith<_$CreateReviewResponseImpl>
      get copyWith =>
          __$$CreateReviewResponseImplCopyWithImpl<_$CreateReviewResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateReviewResponseImplToJson(
      this,
    );
  }
}

abstract class _CreateReviewResponse implements CreateReviewResponse {
  const factory _CreateReviewResponse(
          {@JsonKey(name: 'review_id') required final int reviewId}) =
      _$CreateReviewResponseImpl;

  factory _CreateReviewResponse.fromJson(Map<String, dynamic> json) =
      _$CreateReviewResponseImpl.fromJson;

  @override
  @JsonKey(name: 'review_id')
  int get reviewId;

  /// Create a copy of CreateReviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateReviewResponseImplCopyWith<_$CreateReviewResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
