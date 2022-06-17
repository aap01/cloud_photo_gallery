import 'package:cloud_photo_gallery/core/api/api_impl.dart';
import 'package:cloud_photo_gallery/core/cache/cache_manager.dart';
import 'package:cloud_photo_gallery/core/network/network_connection_checker_impl.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/data_source/remote/photo_remote_source_impl.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/repository/photo_repository_impl.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/usecase/get_photo_list_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();
  static Future<void> inject() async {
    sl.registerFactory(
        () => GetPhotoListUsecase(photoRepository: sl<PhotoRepositoryImpl>()));
    sl.registerLazySingleton(
      () => PhotoRepositoryImpl(
        photoRemoteDataSource: sl<PhotoRemoteDataSourceImpl>(),
        networkConnectionChecker: sl<NetworkConnectionCheckerImpl>(),
      ),
    );
    sl.registerLazySingleton(
      () => PhotoRemoteDataSourceImpl(api: sl<ApiImpl>()),
    );
    sl.registerLazySingleton(
      () => ApiImpl(dio: sl()),
    );
    sl.registerLazySingleton(
      () => NetworkConnectionCheckerImpl(),
    );

    sl.registerLazySingleton(() => AppCacheManager(baseCacheManager: sl()));

    // 3rd party
    sl.registerLazySingleton(
      () => Dio(),
    );
    sl.registerLazySingleton<BaseCacheManager>(() => DefaultCacheManager());
  }
}
