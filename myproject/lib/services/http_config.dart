import 'package:shared_preferences/shared_preferences.dart';

class HttpConfig {
  static Future<Map<String, String>> get headers async {
    final token = await getTokenFromStorage();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future getTokenFromStorage() async {
    final pref= await SharedPreferences.getInstance();
    return pref.getString('token');
  }
}
