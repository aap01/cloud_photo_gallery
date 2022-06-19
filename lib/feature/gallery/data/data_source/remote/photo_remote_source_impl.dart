import 'package:cloud_photo_gallery/core/constant/message_constants.dart';
import 'package:cloud_photo_gallery/core/exception/server_exception.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/data_source/remote/photo_remote_data_source.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/page_listing_model.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_logger/dio_logger.dart';

import '../../../../../core/constant/build_constants.dart';
import '../../../../../core/error_model/error_model.dart';
import '../../model/photo_model.dart';

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  @override
  String get photoListEndpoint => '/photos';

  @override
  int get connectionTimeout => 5000;

  @override
  String get baseUrl => 'https://api.unsplash.com';

  late Dio _dio;
  late CacheStore _cacheStore;

  static const _headers = <String, dynamic>{
    'Content-Type': 'application/json',
  };

  // This key must be hidden in a file which should not be version controlled
  // TODO: Move to an untracked file
  static const _staticParams = <String, dynamic>{
    'client_id': 'dibkYN-2v5YRxazoVMhj3xkNY9YFh87Jcy93SUGDzp0',
  };

  PhotoRemoteDataSourceImpl({
    required Dio dio,
    required CacheStore cacheStore,
  }) {
    _cacheStore = cacheStore;
    _dio = dio;
    _dio.options = BaseOptions(
      connectTimeout: connectionTimeout,
      baseUrl: baseUrl,
    );
    _dio.options.headers.addAll(_headers);
    _dio.options.queryParameters.addAll(_staticParams);
    if (BuildConstants.debug) {
      _dio.interceptors.add(dioLoggerInterceptor);
    }
    _dio.interceptors.add(DioCacheInterceptor(options: options));
  }

  @override
  Future<List<PhotoModel>> fetchPhotos({
    required int perPage,
    required int page,
  }) async {
    final qParams = PageListingModel(page: page, perPage: perPage).toJson();
    qParams.addAll(_staticParams);
    try {
      final response = await _dio.get(
        photoListEndpoint,
        queryParameters: qParams,
      );
      return (response.data as List)
          .map((e) => PhotoModel.fromJson(e))
          .toList();
    } on DioError catch (err) {
      switch (err.type) {
        case DioErrorType.response:
          if (err.response != null && err.response!.data != null) {
            throw ServerException(
              message: ErrorModel.fromJson(err.response!.data).errors.first,
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
      throw const ServerException(message: MessageConstants.internalError);
    }
  }

  CacheOptions get options => CacheOptions(
        // A default store is required for interceptor.
        store: _cacheStore,

        // All subsequent fields are optional.

        // Default.
        policy: CachePolicy.request,
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
