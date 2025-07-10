import 'package:freezed_annotation/freezed_annotation.dart';

part 'help_list_item.freezed.dart';
part 'help_list_item.g.dart';

@freezed
class HelpListItem with _$HelpListItem {
  const factory HelpListItem({
    @JsonKey(name: 'help_id') int? helpId,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'content') required String content,
  }) = _HelpListItem;

  factory HelpListItem.fromJson(Map<String, dynamic> json) => _$HelpListItemFromJson(json);
}