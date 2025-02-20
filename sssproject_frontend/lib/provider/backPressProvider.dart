import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BackPressProvider with ChangeNotifier {
  DateTime? lastBackPressTime;
  bool isDialog = false;

  void onBackPress() {
    DateTime now = DateTime.now();
    if (lastBackPressTime == null || now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
      lastBackPressTime = now;
      isDialog = true;
      notifyListeners();
    } else {
      SystemNavigator.pop();
    }
  }

  void showDialogEnded() {
    isDialog = false;
    notifyListeners();
  }
}