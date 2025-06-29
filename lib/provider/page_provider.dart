import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int currentIndex;

  PageProvider({this.currentIndex = 0});

  void setIndex(int index) {
    if (index != currentIndex) {
      currentIndex = index;
      notifyListeners();
    }
  }
}
