import 'package:myproject/utils/utility.dart';

class HttpConfig {
  // static late String _token;

  // static _getToken() async {
  //   Utility.getSharedPreferance(
  //     "token",
  //   ).then((value) => _token = value.toString());
  // }

  static Future<String?> _getToken() async {
    final token = await Utility.getSharedPreferance("token");
    return token.toString();
  }

  static Future<Map<String, String>> get headers async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty)
       'Authorization': 'Bearer $token',
    };
  }

  // static Future getTokenFromStorage() async {
  //   final pref= await SharedPreferences.getInstance();
  //   return pref.getString('token');
  // }
}
