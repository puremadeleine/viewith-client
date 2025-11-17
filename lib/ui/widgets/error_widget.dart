import 'package:flutter/material.dart';
import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/utils/global_error_handler.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:dio/dio.dart';

/// 공통 에러 위젯
/// 
/// 사용 예시:
/// ```dart
/// error: (err, stack) => ErrorWidget(
///   error: _mapExceptionToError(err),
///   onRetry: () => ref.invalidate(someProvider),
/// )
/// ```
class ErrorWidget extends StatefulWidget {
  final BaseError error;
  final VoidCallback? onRetry;
  final String? customMessage;
  final DioException? dioException; // 화면 전체 에러 위젯인 경우 전달

  const ErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.customMessage,
    this.dioException,
  });

  @override
  State<ErrorWidget> createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorWidget> {
  @override
  void initState() {
    super.initState();
    // 화면 전체에 에러 위젯이 표시되는 경우, 해당 에러를 "처리됨"으로 표시
    // 이렇게 하면 전역 알림이 중복으로 표시되지 않음
    if (widget.dioException != null) {
      GlobalErrorHandler.markErrorAsHandled(widget.dioException!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppDesign.colors.gray400,
            ),
            const SizedBox(height: 16),
            Text(
              widget.customMessage ?? _getErrorMessage(widget.error),
              style: AppDesign.typo.body1(color: AppDesign.colors.gray900),
              textAlign: TextAlign.center,
            ),
            if (widget.onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppDesign.colors.gray900,
                  foregroundColor: AppDesign.colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: widget.onRetry,
                child: Text(
                  '다시 시도',
                  style: AppDesign.typo.body1Bold(color: AppDesign.colors.white),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(BaseError error) {
    if (error is NetworkError) {
      return '네트워크 연결을 확인해주세요.\n잠시 후 다시 시도해주세요.';
    }
    
    // DioException 처리
    if (error.message.contains('connection timeout') || 
        error.message.contains('timeout')) {
      return '요청 시간이 초과되었습니다.\n네트워크 상태를 확인하고 다시 시도해주세요.';
    }
    
    if (error.message.contains('SocketException') || 
        error.message.contains('Failed host lookup')) {
      return '인터넷 연결을 확인해주세요.';
    }
    
    // 기본 에러 메시지
    if (error.message.isNotEmpty && 
        !error.message.contains('DioException') &&
        !error.message.contains('Exception')) {
      return error.message;
    }
    
    return '일시적인 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.';
  }
}

/// Exception을 BaseError로 변환하는 유틸리티 함수
BaseError mapExceptionToError(Object exception) {
  if (exception is DioException) {
    if (exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.receiveTimeout ||
        exception.type == DioExceptionType.sendTimeout) {
      return NetworkError();
    }
    if (exception.type == DioExceptionType.connectionError) {
      return NetworkError();
    }
    return ApiError(
      code: exception.response?.statusCode ?? 9999,
      message: exception.message ?? '네트워크 오류가 발생했습니다.',
    );
  }
  return UnknownError();
}

