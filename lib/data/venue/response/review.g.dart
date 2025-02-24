// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      reviewId: (json['review_id'] as num).toInt(),
      content: json['content'] as String,
      rating: (json['rating'] as num).toDouble(),
      createTime: (json['create_time'] as num).toInt(),
      imageList: (json['image_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userInfo: UserInfo.fromJson(json['user_info'] as Map<String, dynamic>),
      seatRawData:
          SeatRawData.fromJson(json['seat_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'review_id': instance.reviewId,
      'content': instance.content,
      'rating': instance.rating,
      'create_time': instance.createTime,
      'image_list': instance.imageList,
      'user_info': instance.userInfo,
      'seat_info': instance.seatRawData,
    };

_$UserInfoImpl _$$UserInfoImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoImpl(
      userId: (json['user_id'] as num).toInt(),
      userNickname: json['user_nickname'] as String,
    );

Map<String, dynamic> _$$UserInfoImplToJson(_$UserInfoImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_nickname': instance.userNickname,
    };

_$SeatRawDataImpl _$$SeatRawDataImplFromJson(Map<String, dynamic> json) =>
    _$SeatRawDataImpl(
      floor: json['floor'] as String,
      section: json['section'] as String,
      row: (json['seat_row'] as num).toInt(),
      column: (json['seat_column'] as num).toInt(),
      block: json['block'] as String?,
    );

Map<String, dynamic> _$$SeatRawDataImplToJson(_$SeatRawDataImpl instance) =>
    <String, dynamic>{
      'floor': instance.floor,
      'section': instance.section,
      'seat_row': instance.row,
      'seat_column': instance.column,
      'block': instance.block,
    };
