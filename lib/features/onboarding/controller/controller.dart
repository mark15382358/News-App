import 'package:flutter/material.dart';

class onBoardingController extends ChangeNotifier {
  PageController pageController = PageController();
  bool isLastPage = false;
  int currentIndex = 0;
  onPageChanged(int index) {
    currentIndex = index;
    if (currentIndex == 2) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }
    notifyListeners();
  }
}
