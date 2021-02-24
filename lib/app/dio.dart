import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class GetDio {
  static Dio getDio({loggedIn = true, baseURL}) {
    Dio dio = Dio();
    dio.interceptors
      ..add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
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
          return options;
        }
      }, onResponse: (Response response) async {
        return response;
      }, onError: (DioError error) async {
        return error.response;
      }))
      ..add(DioCacheManager(CacheConfig(baseUrl: baseURL)).interceptor);
    return dio;
  }
}
