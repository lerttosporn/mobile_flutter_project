import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  int _seconds = 0;
  int _countDown = 0;
  Timer? _timer;
  bool _isRunning = false;

  int get seconds => _seconds;
  int get countDown => _countDown;
  bool get isRunning => _isRunning;

  // Constructor
  TimerProvider() {
    startTimer();
  }

  void startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _seconds++;
      notifyListeners();
    });
  }

  void stopTimer() {
    _isRunning = false;
    _timer?.cancel();
    notifyListeners();
  }

  void countDown10Sec() {
    _countDown = 10;
    _isRunning = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_countDown == 0) {
        return;
      }
      notifyListeners();
      _countDown--;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
