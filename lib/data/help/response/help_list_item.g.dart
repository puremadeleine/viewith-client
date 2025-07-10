// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HelpListItemImpl _$$HelpListItemImplFromJson(Map<String, dynamic> json) =>
    _$HelpListItemImpl(
      helpId: (json['help_id'] as num?)?.toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$$HelpListItemImplToJson(_$HelpListItemImpl instance) =>
    <String, dynamic>{
      'help_id': instance.helpId,
      'title': instance.title,
      'content': instance.content,
    };
