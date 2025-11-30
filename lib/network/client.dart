import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import '../app_environment.dart';
import 'package:viewith/core/utils/global_error_handler.dart';
import 'package:viewith/network/token_handler.dart';

// HttpOverrides must be set from within an executable context, not at top-level.

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class Client {
  late Dio _dio;
  final TokenHandler _tokenHandler;

  Client(this._tokenHandler, {String baseUrl = baseURL}) {
    // Allow self-signed certificates (development only)
    HttpOverrides.global = MyHttpOverrides();
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _addInterceptors();
  }

  Future<Map<String, String>?> _refreshToken(String? refreshToken) async {
    try {
      if (refreshToken == null) return null;

      final response = await _dio.put(
        '/v1/members/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(extra: {'requiresAuth': false}),
      );

      if (response.statusCode == 200) {
        return {
          'accessToken': response.data['access_token'],
          'refreshToken': response.data['refresh_token'],
        };
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.extra['requiresAuth'] == false) {
            return handler.next(options);
          }

          final hasTokens = await _tokenHandler.hasTokens();
          if (!hasTokens) {
            return handler.reject(
              DioException(
                requestOptions: options,
                error: 'Authentication required',
              ),
            );
          }

          final token = await _tokenHandler.getAccessToken();
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          if (response.data is Map && response.data['value'] != null) {
            response.data = response.data['value'];
          }
          return handler.next(response);
        },
        onError: (error, handler) async {
          bool errorHandled = false;

          // 인증이 필요한 API에서 401이 떨어진 경우 → 토큰 만료/유효하지 않음
          if (error.response?.statusCode == 401 &&
              error.requestOptions.extra['requiresAuth'] == true) {
            final refreshToken = await _tokenHandler.getRefreshToken();

            // 리프레시 토큰 자체가 없으면 바로 로그아웃 처리
            if (refreshToken == null) {
              await _tokenHandler.clearTokens();
              errorHandled =
                  true; // 401 에러는 이미 UI에서 처리되므로 전역 알림 스킵
              return handler.next(error);
            }

            try {
              final response = await _refreshToken(refreshToken);

              if (response != null) {
                final accessToken = response['accessToken'];
                final newRefreshToken = response['refreshToken'];

                if (accessToken != null && newRefreshToken != null) {
                  await _tokenHandler.saveTokens(
                    accessToken: accessToken,
                    refreshToken: newRefreshToken,
                  );
                  // 갱신된 액세스 토큰으로 원래 요청 재시도
                  error.requestOptions.headers['Authorization'] =
                      'Bearer $accessToken';
                  final retryResponse = await _dio.fetch(error.requestOptions);
                  return handler.resolve(retryResponse);
                } else {
                  // 서버 응답에 토큰이 제대로 안 온 경우 → 강제 로그아웃
                  await _tokenHandler.clearTokens();
                  errorHandled = true;
                  return handler.next(error);
                }
              } else {
                // _refreshToken 이 null 을 반환한 경우
                // (예: 401 invalid token 등) → 강제 로그아웃
                await _tokenHandler.clearTokens();
                errorHandled = true;
                return handler.next(error);
              }
            } catch (e) {
              // 리프레시 요청 도중 예외 발생 → 강제 로그아웃
              await _tokenHandler.clearTokens();
              errorHandled = true; // 토큰 리프레시 실패는 이미 처리됨
            }
          }

          // 처리되지 않은 에러만 전역 알림 표시
          if (!errorHandled) {
            // skipGlobalError 플래그가 있으면 스킵
            final skipGlobalError =
                error.requestOptions.extra['skipGlobalError'] == true;
            if (!skipGlobalError) {
              GlobalErrorHandler.showError(error);
            }
          }

          return handler.next(error);
        },
      ),
    );

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    int maxRetries = 3,
    bool requiresAuth = false,
  }) async {
    try {
      return await retry(
        () => _dio.get(
          path,
          queryParameters: queryParameters,
          options: Options(extra: {'requiresAuth': requiresAuth}),
        ),
        retryIf: (error) => error is DioException && error.type != DioExceptionType.cancel && error.type != DioExceptionType.badResponse,
        maxAttempts: maxRetries,
        delayFactor: const Duration(seconds: 1),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    int maxRetries = 3,
    bool requiresAuth = true,
  }) async {
    try {
      return await retry(
        () => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            extra: {'requiresAuth': requiresAuth},
            contentType: data is FormData ? 'multipart/form-data' : null,
          ),
        ),
        retryIf: (error) => error is DioException && error.type != DioExceptionType.cancel && error.type != DioExceptionType.badResponse,
        maxAttempts: maxRetries,
        delayFactor: const Duration(seconds: 1),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    int maxRetries = 3,
    bool requiresAuth = true,
  }) async {
    try {
      return await retry(
        () => _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(extra: {'requiresAuth': requiresAuth}),
        ),
        retryIf: (error) => error is DioException && error.type != DioExceptionType.cancel && error.type != DioExceptionType.badResponse,
        maxAttempts: maxRetries,
        delayFactor: const Duration(seconds: 1),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    int maxRetries = 3,
    bool requiresAuth = true,
  }) async {
    try {
      return await retry(
        () => _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(extra: {'requiresAuth': requiresAuth}),
        ),
        retryIf: (error) => error is DioException && error.type != DioExceptionType.cancel && error.type != DioExceptionType.badResponse,
        maxAttempts: maxRetries,
        delayFactor: const Duration(seconds: 1),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int maxRetries = 3,
  }) async {
    try {
      return await retry(
        () => _dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ),
        retryIf: (error) => error is DioException && error.type != DioExceptionType.cancel && error.type != DioExceptionType.badResponse,
        maxAttempts: maxRetries,
        delayFactor: const Duration(seconds: 1),
      );
    } catch (e) {
      rethrow;
    }
  }
}
