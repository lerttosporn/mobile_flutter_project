// utility.dart
// This file contains utility functions for the project.

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Utility {
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
 
static showAlertDialog( context,  title,  content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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
