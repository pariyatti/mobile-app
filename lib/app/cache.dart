import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class CacheManager {
  static Options todayCards({bool refresh = true}) =>
      buildCacheOptions(Duration(seconds: 15),
          maxStale: Duration(days: 7), forceRefresh: refresh);

  static Options images({bool refresh = true}) =>
      buildCacheOptions(Duration(seconds: 15),
          maxStale: Duration(days: 7), forceRefresh: refresh);
}
