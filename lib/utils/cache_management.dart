import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheManagement {
  static Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();
  }
}
