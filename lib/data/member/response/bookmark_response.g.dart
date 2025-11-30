// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookmarkResponseImpl _$$BookmarkResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BookmarkResponseImpl(
      venueId: (json['venue_id'] as num).toInt(),
      venueName: json['venue_name'] as String,
      bookmarkFloors: (json['bookmark_floors'] as List<dynamic>)
          .map((e) => Floor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BookmarkResponseImplToJson(
        _$BookmarkResponseImpl instance) =>
    <String, dynamic>{
      'venue_id': instance.venueId,
      'venue_name': instance.venueName,
      'bookmark_floors': instance.bookmarkFloors,
    };

_$FloorImpl _$$FloorImplFromJson(Map<String, dynamic> json) => _$FloorImpl(
      bookmarkFloor: json['bookmark_floor'] as String,
      bookmarkSeats: (json['bookmark_seats'] as List<dynamic>)
          .map((e) => BookmarkedSeat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FloorImplToJson(_$FloorImpl instance) =>
    <String, dynamic>{
      'bookmark_floor': instance.bookmarkFloor,
      'bookmark_seats': instance.bookmarkSeats,
    };

_$BookmarkedSeatImpl _$$BookmarkedSeatImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkedSeatImpl(
      bookmarkId: (json['bookmark_id'] as num).toInt(),
      bookmarkSection: json['bookmark_section'] as String?,
      bookmarkRow: json['bookmark_row'] as String?,
      lastUpdateDate: (json['last_update_date'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BookmarkedSeatImplToJson(
        _$BookmarkedSeatImpl instance) =>
    <String, dynamic>{
      'bookmark_id': instance.bookmarkId,
      'bookmark_section': instance.bookmarkSection,
      'bookmark_row': instance.bookmarkRow,
      'last_update_date': instance.lastUpdateDate,
    };
