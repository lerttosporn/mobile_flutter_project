import 'package:dio/dio.dart';
import 'package:myproject/utils/constant.dart';
import 'package:myproject/utils/utility.dart';
class DioConfig {
  static final Dio _dio = Dio()


    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';
          // options.headers['Authorization']='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFhYUBnbWFpbC5jb20iLCJpYXQiOjE3NTg3NzExMzZ9.AdqpV5k8ge-qpCa-jdQfTqLp2F_Ld9Arl2oQSJN7uXo';
          options.baseUrl = baseURLAPI;
          // Do something before request is sent
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) {
          switch (e.response?.statusCode) {
            case 400:
              // Handle Bad Request
              Utility.logger.e("Bad Request");
              break;
            case 401:
              // Handle Unauthorized
              Utility.logger.e("Unauthorized");
              break;
            case 403:
              // Handle Forbidden
              Utility.logger.e("Forbidden");
              break;
            case 404:
              // Handle Not Found
              Utility.logger.e("Not Found");
              break;
            case 500:
              // Handle Internal Server Error
              Utility.logger.e("Internal Server Error");
              break;
            default:
              // Handle other status codes
              Utility.logger.e("Something went wrong");
              break;
          }
          // Do something with response error
          return handler.next(e); // continue
        },
      ),
    );
  

  static Dio get dio => _dio;
}
