import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:viewith/core/result/paginated_response.dart';
import 'package:viewith/core/result/result.dart';

import 'base_error.dart';

extension ApiResponseParser on Response {
  Result<T, BaseError> toResult<T>({
    String? key,
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    try {
      switch (statusCode) {
        case 200:
          final jsonData = data as Map<String, dynamic>;
          final targetData = key != null ? jsonData[key] : jsonData;
          return Success(fromJson(targetData));

        default:
          _logError('API Error', 'Status Code: $statusCode, Message: $statusMessage');
          return Failure(ApiError(code: statusCode ?? -1, message: statusMessage ?? ''));
      }
    } catch (e, stackTrace) {
      _logError('Parse Error in toResult', e.toString(), stackTrace);
      return Failure(UnknownError());
    }
  }

  Result<List<T>, BaseError> toListResult<T>({
    String? key,
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    try {
      switch (statusCode) {
        case 200:
          final jsonData = data as Map<String, dynamic>;
          final List targetList = key != null ? jsonData[key] : jsonData;

          return Success(
            targetList.cast<Map<String, dynamic>>().map(fromJson).toList(),
          );

        default:
          _logError('API Error', 'Status Code: $statusCode, Message: $statusMessage');
          return Failure(ApiError(code: statusCode ?? -1, message: statusMessage ?? ''));
      }
    } catch (e, stackTrace) {
      _logError('Parse Error in toListResult', e.toString(), stackTrace);
      return Failure(UnknownError());
    }
  }

  Result<PaginatedResponse<T>, BaseError> toPaginatedResult<T>(
    T Function(Object?) fromJsonT,
  ) {
    try {
      if (statusCode != 200) {
        _logError('API Error', 'Status Code: $statusCode, Message: $statusMessage');
        return Failure(ApiError(code: statusCode ?? -1, message: statusMessage ?? ''));
      }

      return Success(
        PaginatedResponse.fromJson(
          data as Map<String, dynamic>,
          fromJsonT,
        ),
      );
    } catch (e, stackTrace) {
      _logError('Parse Error in toPaginatedResult', e.toString(), stackTrace);
      return Failure(UnknownError());
    }
  }

  void _logError(String type, String message, [StackTrace? stackTrace]) {
    developer.log(
      message,
      name: type,
      error: message,
      stackTrace: stackTrace,
    );

    // Debug 모드에서는 print도 함께 사용
    if (kDebugMode) {
      print('[$type] $message');
      if (stackTrace != null) {
        print(stackTrace);
      }
    }
  }
}

BaseError mapErrorResponse(int code, String message) {
  return switch (code) { _ => UnknownError() };
}
