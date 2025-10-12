// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportReviewRequestImpl _$$ReportReviewRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ReportReviewRequestImpl(
      reportReason: json['report_reason'] as String?,
      reportReasonDetail: json['report_reason_detail'] as String?,
    );

Map<String, dynamic> _$$ReportReviewRequestImplToJson(
        _$ReportReviewRequestImpl instance) =>
    <String, dynamic>{
      'report_reason': instance.reportReason,
      'report_reason_detail': instance.reportReasonDetail,
    };
