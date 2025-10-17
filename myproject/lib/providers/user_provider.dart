import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myproject/utils/app_router.dart';
import 'package:myproject/utils/utility.dart';

class UserProvider extends ChangeNotifier {
  Map<String, dynamic>? _user;
  Map<String, dynamic>? get user => _user;

  Future<void> loadUserProfile() async {
    final userString = await Utility.getSharedPreferance("user");
    if (userString != null) {
      _user = jsonDecode(userString);
      Utility.logger.i("User Info : $_user");
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await Utility.deleteSharedPreferance("token");
    await Utility.deleteSharedPreferance("loginStatus");
    clearUser();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.login, // <-- 'login'
      (route) => false,
    );
    Utility.logger.i(_user);
  }
}
