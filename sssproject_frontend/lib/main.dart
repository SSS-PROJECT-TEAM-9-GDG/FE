import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sssproject_frontend/provider/backPressProvider.dart';
import 'package:sssproject_frontend/view/customNavigationBar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BackPressProvider(),
      child: const MyApp(),
    ),
  );
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
