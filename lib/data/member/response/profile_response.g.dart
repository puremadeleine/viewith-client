// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileResponseImpl _$$ProfileResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileResponseImpl(
      nickname: json['nickname'] as String,
      writtenReviewsCount: (json['written_reviews_count'] as num).toInt(),
      bookmarkCount: (json['bookmarks_count'] as num).toInt(),
    );

Map<String, dynamic> _$$ProfileResponseImplToJson(
        _$ProfileResponseImpl instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'written_reviews_count': instance.writtenReviewsCount,
      'bookmarks_count': instance.bookmarkCount,
    };
