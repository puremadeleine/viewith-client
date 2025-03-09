// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookmarkInfoImpl _$$BookmarkInfoImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkInfoImpl(
      venueId: (json['venueId'] as num).toInt(),
      venueName: json['venueName'] as String,
      bookmarkFloors: (json['bookmarkFloors'] as List<dynamic>)
          .map((e) => Floor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BookmarkInfoImplToJson(_$BookmarkInfoImpl instance) =>
    <String, dynamic>{
      'venueId': instance.venueId,
      'venueName': instance.venueName,
      'bookmarkFloors': instance.bookmarkFloors,
    };

_$FloorImpl _$$FloorImplFromJson(Map<String, dynamic> json) => _$FloorImpl(
      bookmarkFloor: json['bookmarkFloor'] as String,
      bookmarkSeats: (json['bookmarkSeats'] as List<dynamic>)
          .map((e) => BookmarkedSeat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FloorImplToJson(_$FloorImpl instance) =>
    <String, dynamic>{
      'bookmarkFloor': instance.bookmarkFloor,
      'bookmarkSeats': instance.bookmarkSeats,
    };

_$BookmarkedSeatImpl _$$BookmarkedSeatImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkedSeatImpl(
      bookmarkId: (json['bookmarkId'] as num).toInt(),
      bookmarkSection: json['bookmarkSection'] as String?,
      bookmarkRow: (json['bookmarkRow'] as num?)?.toInt(),
      lastUpdateDate: json['lastUpdateDate'] == null
          ? null
          : DateTime.parse(json['lastUpdateDate'] as String),
    );

Map<String, dynamic> _$$BookmarkedSeatImplToJson(
        _$BookmarkedSeatImpl instance) =>
    <String, dynamic>{
      'bookmarkId': instance.bookmarkId,
      'bookmarkSection': instance.bookmarkSection,
      'bookmarkRow': instance.bookmarkRow,
      'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
    };
