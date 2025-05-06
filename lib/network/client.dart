import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:viewith/app_environment.dart';
import 'package:viewith/network/token_handler.dart';

class Client {
  late Dio _dio;
  final TokenHandler _tokenHandler;

  Client(this._tokenHandler, {String baseUrl = baseURL}) {
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
          if (error.response?.statusCode == 401 && error.requestOptions.extra['requiresAuth'] == true) {
            final refreshToken = await _tokenHandler.getRefreshToken();
            if (refreshToken == null) {
              await _tokenHandler.clearTokens();
              return handler.next(error);
            }

            try {
              final response = await _refreshToken(refreshToken);
              if (response != null) {
                final accessToken = response['accessToken'];
                final refreshToken = response['refreshToken'];
                if (accessToken != null && refreshToken != null) {
                  await _tokenHandler.saveTokens(
                    accessToken: accessToken,
                    refreshToken: refreshToken,
                  );
                } else {
                  await _tokenHandler.clearTokens();
                  return handler.next(error);
                }
                error.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
                final retryResponse = await _dio.fetch(error.requestOptions);
                return handler.resolve(retryResponse);
              }
            } catch (e) {
              await _tokenHandler.clearTokens();
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
