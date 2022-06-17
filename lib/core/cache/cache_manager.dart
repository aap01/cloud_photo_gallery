import 'package:flutter_cache_manager/flutter_cache_manager.dart';

abstract class CacheManager {
  Future<String> getCachedFilePath(String key);
}

class AppCacheManager extends CacheManager {
  late BaseCacheManager _baseCacheManager;

  AppCacheManager({required BaseCacheManager baseCacheManager}) {
    _baseCacheManager = baseCacheManager;
  }

  @override
  Future<String> getCachedFilePath(String key) async {
    return (await _baseCacheManager.getSingleFile(key)).path;
  }
}
