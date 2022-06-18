// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/core/api/api.dart';
import 'package:cloud_photo_gallery/core/api/api_response.dart';
import 'package:cloud_photo_gallery/core/constant/build_constants.dart';
import 'package:cloud_photo_gallery/core/constant/message_constants.dart';
import 'package:cloud_photo_gallery/core/error_model/error_model.dart';
import 'package:cloud_photo_gallery/core/exception/server_exception.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_logger/dio_logger.dart';

class ApiImpl extends Api {
  late Dio _dio;
  late CacheStore _cacheStore;
  static const _headers = <String, dynamic>{
    'Content-Type': 'application/json',
  };

  // This key must be hidden in a file which should not be version controlled
  // TODO: Move to an untracked file
  static const _qParams = <String, dynamic>{
    'client_id': 'dibkYN-2v5YRxazoVMhj3xkNY9YFh87Jcy93SUGDzp0',
  };

  ApiImpl({
    required Dio dio,
    required CacheStore cacheStore,
  }) {
    _cacheStore = cacheStore;
    _dio = dio;
    _dio.options = BaseOptions(connectTimeout: connectionTimeout);
    if (BuildConstants.debug) {
      _dio.interceptors.add(dioLoggerInterceptor);
    }
    _dio.interceptors.add(DioCacheInterceptor(options: options));
  }

  @override
  Future<ApiResponse> get({
    required url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _addStaticHeader();
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
      );
      return ApiResponse.success(response: response.data);
    } on DioError catch (err) {
      switch (err.type) {
        case DioErrorType.response:
          if (err.response != null && err.response!.data != null) {
            return ApiResponse.error(
              error: ErrorModel.fromJson(err.response!.data),
            );
          }
          throw ServerException(message: err.message);

        case DioErrorType.connectTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.sendTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.receiveTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.cancel:
          // TODO: Handle this case.
          break;
        case DioErrorType.other:
          // TODO: Handle this case.
          break;
      }

      throw ServerException(message: err.message);
    } on Exception catch (_) {
      throw const ServerException(message: MessageConstants.unHandledException);
    } finally {
      _clearHeader();
    }
  }

  void _clearHeader() {
    _dio.options.headers.clear();
    _dio.options.queryParameters.clear();
  }

  void _addStaticHeader() {
    _dio.options.headers.addAll(_headers);
    _dio.options.queryParameters.addAll(_qParams);
  }

  CacheOptions get options => CacheOptions(
        // A default store is required for interceptor.
        store: _cacheStore,

        // All subsequent fields are optional.

        // Default.
        policy: CachePolicy.forceCache,
        // Returns a cached response on error but for statuses 401 & 403.
        // Also allows to return a cached response on network errors (e.g. offline usage).
        // Defaults to [null].
        hitCacheOnErrorExcept: [401, 403],
        // Overrides any HTTP directive to delete entry past this duration.
        // Useful only when origin server has no cache config or custom behaviour is desired.
        // Defaults to [null].
        maxStale: const Duration(days: 7),
        // Default. Allows 3 cache sets and ease cleanup.
        priority: CachePriority.normal,
        // Default. Body and headers encryption with your own algorithm.
        cipher: null,
        // Default. Key builder to retrieve requests.
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        // Default. Allows to cache POST requests.
        // Overriding [keyBuilder] is strongly recommended when [true].
        allowPostMethod: false,
      );
}
