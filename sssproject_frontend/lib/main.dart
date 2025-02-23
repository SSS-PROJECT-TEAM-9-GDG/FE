import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sssproject_frontend/util/provider/backPressProvider.dart';
import 'package:sssproject_frontend/util/view/customNavigationBar.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Pretendard'),
      home: const customNavigationBar(),
    );}
}
