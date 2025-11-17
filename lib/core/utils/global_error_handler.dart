import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/ui/app_design.dart';

/// 전역 에러 핸들러
/// 
/// 처리되지 않은 API 에러를 전역적으로 리슨하고 스낵바로 표시합니다.
class GlobalErrorHandler {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = 
      GlobalKey<ScaffoldMessengerState>();
  
  // 화면 전체에 에러 위젯이 표시되는 경우를 추적
  // 키: 에러의 고유 식별자 (URL + 타임스탬프), 값: 처리 시간
  static final Map<String, DateTime> _handledErrors = {};
  
  // retry로 인한 에러 추적 (처음 한 번만 표시)
  // 키: 에러의 고유 식별자 (URL), 값: 첫 표시 시간
  static final Map<String, DateTime> _retryErrors = {};
  
  /// 에러가 이미 UI에서 처리되었는지 확인
  static bool _isErrorHandledInUI(DioException error) {
    // 특정 에러 코드는 이미 UI에서 처리됨
    if (error.response?.statusCode == 401 || 
        error.response?.statusCode == 404) {
      return true;
    }
    
    // 최근 1초 이내에 동일한 에러가 처리되었는지 확인
    final errorKey = '${error.requestOptions.uri}';
    final handledTime = _handledErrors[errorKey];
    if (handledTime != null) {
      final now = DateTime.now();
      if (now.difference(handledTime).inSeconds < 1) {
        return true;
      }
    }
    
    return false;
  }
  
  /// 에러가 UI에서 처리되었음을 표시
  static void markErrorAsHandled(DioException error) {
    final errorKey = '${error.requestOptions.uri}';
    _handledErrors[errorKey] = DateTime.now();
    
    // 5초 후 자동으로 제거 (메모리 관리)
    Future.delayed(const Duration(seconds: 5), () {
      _handledErrors.remove(errorKey);
    });
  }

  /// 에러 메시지를 사용자 친화적인 메시지로 변환
  static String _getErrorMessage(DioException error) {
    // 특정 에러 코드는 이미 UI에서 처리되므로 스킵
    if (error.response?.statusCode == 401 || 
        error.response?.statusCode == 404) {
      return '';
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return '요청 시간이 초과되었습니다.\n네트워크 상태를 확인하고 다시 시도해주세요.';
    }

    if (error.type == DioExceptionType.connectionError) {
      return '네트워크 연결을 확인해주세요.\n잠시 후 다시 시도해주세요.';
    }

    if (error.response != null) {
      // 서버에서 반환한 에러 메시지가 있으면 사용
      final statusCode = error.response!.statusCode;
      if (statusCode != null && statusCode >= 500) {
        return '서버 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.';
      }
      if (statusCode != null && statusCode >= 400) {
        return '요청을 처리할 수 없습니다.\n잠시 후 다시 시도해주세요.';
      }
    }

    return '일시적인 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.';
  }

  /// 에러를 전역 스낵바로 표시
  /// 
  /// [skipIfHandled]: true인 경우 이미 UI에서 처리된 에러로 간주하고 스킵
  static void showError(DioException error, {bool skipIfHandled = false}) {
    // 이미 UI에서 처리된 에러는 스킵
    if (skipIfHandled) {
      return;
    }

    // UI에서 이미 처리된 에러는 스킵
    if (_isErrorHandledInUI(error)) {
      return;
    }

    final message = _getErrorMessage(error);
    if (message.isEmpty) {
      return;
    }

    // 에러 키 생성 (URL 기반, query parameter 제외하여 같은 API 호출로 인식)
    final uri = error.requestOptions.uri;
    final errorKey = '${uri.scheme}://${uri.host}${uri.path}';
    
    // retry로 인한 에러인지 확인 (30초 이내에 같은 에러가 발생했으면 retry로 간주)
    final now = DateTime.now();
    final lastShownTime = _retryErrors[errorKey];
    
    if (lastShownTime != null) {
      final timeDiff = now.difference(lastShownTime);
      // 30초 이내에 같은 에러가 반복 발생하면 retry로 인한 것으로 간주하고 스킵
      if (timeDiff.inSeconds < 30) {
        return; // retry로 인한 에러는 처음 한 번만 표시
      } else {
        // 30초가 지났으면 새로운 에러로 간주하고 추적 정보 제거
        _retryErrors.remove(errorKey);
      }
    }

    final scaffoldMessenger = scaffoldMessengerKey.currentState;
    if (scaffoldMessenger != null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppDesign.typo.body2(color: AppDesign.colors.white),
          ),
          backgroundColor: AppDesign.colors.gray900,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
          margin: const EdgeInsets.all(16),
        ),
      );
      
      // 에러 표시 시간 저장 (retry 감지용)
      _retryErrors[errorKey] = now;
      
      // 30초 후 자동으로 제거 (메모리 관리)
      Future.delayed(const Duration(seconds: 30), () {
        if (_retryErrors[errorKey] == now) {
          _retryErrors.remove(errorKey);
        }
      });
    }
  }

  /// BaseError를 전역 스낵바로 표시
  static void showBaseError(BaseError error, {bool skipIfHandled = false}) {
    if (skipIfHandled) {
      return;
    }

    // 특정 에러 코드는 이미 UI에서 처리되므로 스킵
    if (error.code == 401 || error.code == 404) {
      return;
    }

    String message;
    if (error is NetworkError) {
      message = '네트워크 연결을 확인해주세요.\n잠시 후 다시 시도해주세요.';
    } else if (error.message.contains('connection timeout') || 
               error.message.contains('timeout')) {
      message = '요청 시간이 초과되었습니다.\n네트워크 상태를 확인하고 다시 시도해주세요.';
    } else if (error.message.contains('SocketException') || 
               error.message.contains('Failed host lookup')) {
      message = '인터넷 연결을 확인해주세요.';
    } else if (error.message.isNotEmpty && 
               !error.message.contains('DioException') &&
               !error.message.contains('Exception')) {
      message = error.message;
    } else {
      message = '일시적인 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.';
    }

    final scaffoldMessenger = scaffoldMessengerKey.currentState;
    if (scaffoldMessenger != null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppDesign.typo.body2(color: AppDesign.colors.white),
          ),
          backgroundColor: AppDesign.colors.gray900,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }
}

