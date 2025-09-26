import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myproject/services/http_config.dart';
import 'package:myproject/utils/constant.dart';
import 'package:myproject/utils/utility.dart';

class CallAPI {
Future<Map<String, dynamic>> registerApi(data) async {
    Utility.logger.d(data);
  try {
    final response = await http.post(
      Uri.parse('${baseURLAPI}/auth/register'),
      headers: await HttpConfig.headers,
      body: jsonEncode(data),
    );
    Utility.logger.d(response.body);
     return jsonDecode(response.body);
  } catch (e) {
    Utility.logger.e(e.toString());
    return {'message': 'Error'};
  } 
}
Future<Map<String, dynamic>> loginApi(data) async {
  Utility.logger.d(data);
  try {
    final response = await http.post(
      Uri.parse('${baseURLAPI}/auth/login'),
      headers: await HttpConfig.headers,
      body: jsonEncode(data),
    );
    Utility.logger.d(response.body);
     return jsonDecode(response.body);
  } catch (e) {
    Utility.logger.e(e.toString());
    return {'message': 'Error'};
  } 
}
Future<List<dynamic>> getProducts() async {
  const token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFhYUBnbWFpbC5jb20iLCJpYXQiOjE3NTg4NTc1ODN9.Q4Wv1JIblspZhRFgYoEE9_MfXAiafulGn3r_zBnI1zU';
  try {
    final response = await http.get(
      Uri.parse('${baseURLAPI}/products'),
     headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}', // <-- ใส่ token ตรงนี้
      },
    );
    Utility.logger.d(response.body);
    return jsonDecode(response.body);
  } catch (e) {
Utility.logger.e('Error: $e');
    return []; // ← ส่งกลับ list ว่างเมื่อ error
  }
  
}
  // final Dio _dio = DioConfig.dio;

  // registerAPI(data) async {
  //   //check connection
  //   // if (await Utility.logger.d.checkNetwork() == 'No Network Connection') {
  //   //   return jsonEncode({'message': 'No Network Connection'});
  //   // } else {
  //         logger.d(data);
  //   try {
  //     final response = await _dio.post(
  //       '/auth/register',
  //       data: data,
  //     );
  //     logger.d(response.data);
  //     return jsonEncode(response.data);
  //   } catch (e) {
  //     logger.e(e);
  //     return jsonEncode({'message': 'Error'});
  //   }
  //   // }
  // }
}
