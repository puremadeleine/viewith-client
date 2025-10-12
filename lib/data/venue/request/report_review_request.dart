import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:viewith/data/venue/request/report_reason.dart';

part 'report_review_request.freezed.dart';
part 'report_review_request.g.dart';

@freezed
class ReportReviewRequest with _$ReportReviewRequest {
  const factory ReportReviewRequest({
    @JsonKey(name: 'report_reason') String? reportReason,
    @JsonKey(name: 'report_reason_detail') String? reportReasonDetail,
  }) = _ReportReviewRequest;

  factory ReportReviewRequest.fromJson(Map<String, dynamic> json) => _$ReportReviewRequestFromJson(json);
}
