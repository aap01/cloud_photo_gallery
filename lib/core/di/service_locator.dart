import 'package:cloud_photo_gallery/core/cache/cache_manager.dart';
import 'package:cloud_photo_gallery/core/cache/file_saver.dart';
import 'package:cloud_photo_gallery/core/network/netowork_connection_checker.dart';
import 'package:cloud_photo_gallery/core/network/network_connection_checker_impl.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/data_source/remote/photo_remote_source_impl.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/repository/photo_repository_impl.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/usecase/get_photo_list_usecase.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

import '../../feature/gallery/data/data_source/remote/photo_remote_data_source.dart';
import '../../feature/gallery/domain/repository/photo_repository.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();
  static Future<void> inject() async {
    sl.registerFactory(() => GetPhotoListUsecase(photoRepository: sl()));
    sl.registerLazySingleton<PhotoRepository>(
      () => PhotoRepositoryImpl(
        photoRemoteDataSource: sl(),
        networkConnectionChecker: sl(),
      ),
    );
    sl.registerLazySingleton<PhotoRemoteDataSource>(
      () => PhotoRemoteDataSourceImpl(
        dio: sl(),
        cacheStore: sl(),
      ),
    );
    sl.registerLazySingleton<NetworkConnectionChecker>(
      () => NetworkConnectionCheckerImpl(),
    );

    sl.registerLazySingleton<AppCacheManager>(
      () => AppCacheManagerImpl(baseCacheManager: sl()),
    );

    final appDirectory = await FileHelper.documentsDirectoryPath;

    // 3rd party
    sl.registerLazySingleton(
      () => Dio(),
    );
    sl.registerLazySingleton<BaseCacheManager>(
      () => DefaultCacheManager(),
    );
    sl.registerLazySingleton<CacheStore>(() => HiveCacheStore(appDirectory));
  }

  static Future<void> closeServices() async {
    sl<Dio>().close();
    await sl<CacheStore>().close();
    await sl<BaseCacheManager>().dispose();
  }
}
