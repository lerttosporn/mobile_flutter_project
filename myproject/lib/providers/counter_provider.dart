import 'dart:math';
import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  increment() {
    _counter++;
    notifyListeners();
  }

  decrement() {
    _counter--;
    notifyListeners();
  }

  Color getColor() {
    final Random random = Random();
    return Color.fromARGB(
      255, // ความโปร่งใส (Alpha) – 255 คือทึบสุด
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
