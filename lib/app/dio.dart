import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:patta/app/cache.dart';
import 'package:patta/app/global.dart';

class GetDio {
  static Dio getDio({
    loggedIn = true,
    baseURL,
    bool cacheEnabled = true,
    CustomCacheOptions? cacheOptions,
  }) {
    cacheOptions ??= CacheManager.defaultCache();
    Dio dio = Dio();
    dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      options.baseUrl = baseURL;
      // options.headers["Accept"] = "application/json";
      // options.headers["setContentType"] = "application/json";
      if (loggedIn == false) {
        //Todo: Add case if user is not logged in
      } else {
        // dio.interceptors.requestLock.lock();
        try {
          //Todo: Add case if user is logged in to add auth token to the headers of HTTP request
          // AuthService.getAccessTokenFromDevice().then((token) async {
          //   options.headers["Authorization"] = "token $token";
          // }).whenComplete(() {
          //   dio.interceptors.requestLock.unlock();
          //   return options;
          // });
        } catch (error) {
          print(error);
        }
        // Check cache first and return cached data if supplied maxAge
        // has not elapsed.
        if (cacheEnabled) {
          final key = CacheOptions.defaultCacheKeyBuilder(options);
          final cache = await cacheStore.get(key);
          if (cache != null &&
              cacheOptions != null &&
              !cacheOptions.refresh &&
              DateTime.now()
                  .isBefore(cache.responseDate.add(cacheOptions.maxAge))) {
            // Resolve the request and pass cached data as response.
            return handler
                .resolve(cache.toResponse(options, fromNetwork: false));
          }
        }
        handler.next(options); //return options;
      }
    }, onResponse: (Response response, handler) async {
      handler.next(response); // return response;
    }, onError: (DioError error, handler) async {
      handler.next(error); // return error.response;
    }));
    if (cacheEnabled) {
      dio.interceptors.add(
        DioCacheInterceptor(options: cacheOptions),
      );
    }
    return dio;
  }
}
