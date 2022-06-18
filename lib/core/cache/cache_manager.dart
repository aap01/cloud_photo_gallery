import 'package:flutter_cache_manager/flutter_cache_manager.dart';

abstract class AppCacheManager {
  Future<String> getCachedFilePath(String key);
}

class AppCacheManagerImpl extends AppCacheManager {
  late BaseCacheManager _baseCacheManager;

  AppCacheManagerImpl({required BaseCacheManager baseCacheManager}) {
    _baseCacheManager = baseCacheManager;
  }

  @override
  Future<String> getCachedFilePath(String key) async {
    return (await _baseCacheManager.getSingleFile(key)).path;
  }
}
