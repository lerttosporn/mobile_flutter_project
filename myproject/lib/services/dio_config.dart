import 'package:dio/dio.dart';

class DioConfig {
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';
          // Do something before request is sent
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) {
          switch(e.response?.statusCode){
            case 400:
              // Handle Bad Request
              print("Bad Request");
              break;
            case 401:
              // Handle Unauthorized
              print("Unauthorized");
              break;
            case 403:
              // Handle Forbidden
              print("Forbidden");
              break;
            case 404:
              // Handle Not Found
              print("Not Found");
              break;
            case 500:
              // Handle Internal Server Error
              print("Internal Server Error");
              break;
            default:
              // Handle other status codes
              print("Something went wrong");
              break;
          }
          // Do something with response error
          return handler.next(e); // continue
        },
      ),
    );
  }
  static Dio get dio => _dio;
}