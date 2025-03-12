import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _count = 5;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Notify UI to update
  }
}
