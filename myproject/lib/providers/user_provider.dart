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

  Future<void> logout(BuildContext context) async {
    await Utility.deleteSharedPreferance("token");
    await Utility.deleteSharedPreferance("loginStatus");

    Navigator.pushAndRemoveUntil(context, AppRouter.login as Route<Object?>, (route) => false);
  }
}
