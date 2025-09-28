// utility.dart
// This file contains utility functions for the project.

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  // Logger------------------------------------------------
  static final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );
  //Test Logger--------------------------------------------
  static void testLogger() {
    logger.d("Debug");
    logger.i("Info");
    logger.w("Warning");
    logger.e("Error");
    logger.f("What a terrible failure");
  }
  //-------------------------------------------------------

  //Cheack Network-----------------------------------------
  static Future<String> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      return 'Connected to Mobile Network';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 'Connected to WiFi';
    } else {
      return 'No Network Connection';
    }
  }

  //Shared Preferences-------------------------------------
  static SharedPreferences? _prefs;

  static Future<void> initiSharedPrefs() async =>
      _prefs ??= await SharedPreferences.getInstance();
  //Set Preference-----------------------------------------
  static Future<bool> setSharedPreference(String key, dynamic value) async {
    if (_prefs == null) {
      return false;
    }
    if (value is String) {
      return await _prefs!.setString(key, value);
    }
    if (value is int) {
      return await _prefs!.setInt(key, value);
    }
    if (value is bool) {
      return await _prefs!.setBool(key, value);
    }
    if (value is double) {
      return await _prefs!.setDouble(key, value);
    }
    return false;
  }

  //Get Preference-----------------------------------------
  static dynamic getSharedPreferance(String key) {
    if (_prefs == null) {
      return null;
    }
    return _prefs!.get(key);
  }

  //Delete Preferance--------------------------------------
  static Future<bool> deleteAllSharedPreferance() async {
    if (_prefs == null) {
      return false;
    }
    return await _prefs!.clear();
  }
  static Future<bool> deleteSharedPreferance(String key) async {
    if (_prefs == null) {
      return false;
    }
    return await _prefs!.remove(key);
  }
  //Alert Dialog-------------------------------------------
static showAlertDialog(BuildContext context, String? title, String? content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? ""),
        content: Text(content ?? ""),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}
