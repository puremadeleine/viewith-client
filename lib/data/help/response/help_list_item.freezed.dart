// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HelpListItem _$HelpListItemFromJson(Map<String, dynamic> json) {
  return _HelpListItem.fromJson(json);
}

/// @nodoc
mixin _$HelpListItem {
  @JsonKey(name: 'help_id')
  int? get helpId => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String get content => throw _privateConstructorUsedError;

  /// Serializes this HelpListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HelpListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HelpListItemCopyWith<HelpListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelpListItemCopyWith<$Res> {
  factory $HelpListItemCopyWith(
          HelpListItem value, $Res Function(HelpListItem) then) =
      _$HelpListItemCopyWithImpl<$Res, HelpListItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'help_id') int? helpId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'content') String content});
}

/// @nodoc
class _$HelpListItemCopyWithImpl<$Res, $Val extends HelpListItem>
    implements $HelpListItemCopyWith<$Res> {
  _$HelpListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HelpListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? helpId = freezed,
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      helpId: freezed == helpId
          ? _value.helpId
          : helpId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HelpListItemImplCopyWith<$Res>
    implements $HelpListItemCopyWith<$Res> {
  factory _$$HelpListItemImplCopyWith(
          _$HelpListItemImpl value, $Res Function(_$HelpListItemImpl) then) =
      __$$HelpListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'help_id') int? helpId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'content') String content});
}

/// @nodoc
class __$$HelpListItemImplCopyWithImpl<$Res>
    extends _$HelpListItemCopyWithImpl<$Res, _$HelpListItemImpl>
    implements _$$HelpListItemImplCopyWith<$Res> {
  __$$HelpListItemImplCopyWithImpl(
      _$HelpListItemImpl _value, $Res Function(_$HelpListItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of HelpListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? helpId = freezed,
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_$HelpListItemImpl(
      helpId: freezed == helpId
          ? _value.helpId
          : helpId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HelpListItemImpl implements _HelpListItem {
  const _$HelpListItemImpl(
      {@JsonKey(name: 'help_id') this.helpId,
      @JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'content') required this.content});

  factory _$HelpListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$HelpListItemImplFromJson(json);

  @override
  @JsonKey(name: 'help_id')
  final int? helpId;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'content')
  final String content;

  @override
  String toString() {
    return 'HelpListItem(helpId: $helpId, title: $title, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HelpListItemImpl &&
            (identical(other.helpId, helpId) || other.helpId == helpId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, helpId, title, content);

  /// Create a copy of HelpListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HelpListItemImplCopyWith<_$HelpListItemImpl> get copyWith =>
      __$$HelpListItemImplCopyWithImpl<_$HelpListItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HelpListItemImplToJson(
      this,
    );
  }
}

abstract class _HelpListItem implements HelpListItem {
  const factory _HelpListItem(
          {@JsonKey(name: 'help_id') final int? helpId,
          @JsonKey(name: 'title') required final String title,
          @JsonKey(name: 'content') required final String content}) =
      _$HelpListItemImpl;

  factory _HelpListItem.fromJson(Map<String, dynamic> json) =
      _$HelpListItemImpl.fromJson;

  @override
  @JsonKey(name: 'help_id')
  int? get helpId;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'content')
  String get content;

  /// Create a copy of HelpListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HelpListItemImplCopyWith<_$HelpListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
