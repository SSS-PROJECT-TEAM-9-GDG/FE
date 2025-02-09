import 'package:flutter/material.dart';
import 'package:sssproject_frontend/view/customNavigationBar.dart';
import 'package:sssproject_frontend/view/homScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Pretendard'),
      home: const customNavigationBar(),
    );}
}
