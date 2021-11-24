import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:patta/app/global.dart';

class CacheManager {
  static CustomCacheOptions defaultCache(
          {bool refresh = false, Duration maxAge = _maxAge}) =>
      CustomCacheOptions(refresh: refresh, maxAge: maxAge);

  static void clearCache() async {
    await cacheStore.clean();
  }
}

const Duration _maxAge = Duration(minutes: 2);

class CustomCacheOptions extends CacheOptions {
  CustomCacheOptions({
    required this.refresh,
    this.maxAge = _maxAge,
    List<int> hitCacheOnErrorExcept = const [401, 403],
    CacheKeyBuilder keyBuilder = CacheOptions.defaultCacheKeyBuilder,
    Duration maxStale = const Duration(days: 7),
    CachePriority priority = CachePriority.normal,
    bool allowPostMethod = false,
    CachePolicy cachePolicy = CachePolicy.request,
  }) : super(
            store: cacheStore,
            policy: refresh ? CachePolicy.refresh : cachePolicy,
            hitCacheOnErrorExcept: hitCacheOnErrorExcept,
            keyBuilder: keyBuilder,
            maxStale: maxStale,
            allowPostMethod: allowPostMethod,
            priority: priority);
  final Duration maxAge;
  final bool refresh;
}
