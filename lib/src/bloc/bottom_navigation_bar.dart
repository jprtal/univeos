import 'package:flutter/material.dart';

class BottomNavigation with ChangeNotifier {

  int _currentIndex = 0;

  get currentIndex {
    return _currentIndex;
  }

  set currentIndex(int index) {
    _currentIndex = index;

    notifyListeners();
  }

}