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
      isDialog = true; // 처음 뒤로가기 눌렀을 때만
      notifyListeners(); // 상태 변경 알림
    } else {
      SystemNavigator.pop(); // 앱 종료
    }
  }

  void showDialogEnded() {
    isDialog = false;
    notifyListeners(); // 상태 변경 알림
  }
}