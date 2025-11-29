import 'package:flutter/material.dart';

mixin SafeNotifyMixines on ChangeNotifier {
    bool isDispose = false;

void notify() {
    if (!isDispose) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }
}