import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/view/customNavigationBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        backgroundColor: backgroundWhite,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundCurve.png'),
            fit: BoxFit.scaleDown,
            alignment: Alignment(0, 1.0))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text('안녕하세요.\n구름이가\n도와드릴게요!', style: TextStyle(fontSize: 32),)),
                Image.asset('assets/images/goormCharactor.png', width: 141, height: 148,)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    cardButton('assets/images/shieldSearchColor.png','URL/번호 검색','알 수 없는 URL이나\n번호를 검색할 수 있어요.'),
                    cardButton('assets/images/unlockColor.png','권한설정','어플이 사용하는 권한을 한눈에 볼 수 있어요.'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    cardButton('assets/images/scanBarcodeColor.png','노이즈 추가','사진에 노이즈를 추가하여 딥페이크를 방지해요.'),
                    cardButton('assets/images/alarmColor.png','신고 방법','문제가 생겼을 때\n대처방법을 알아보아요.'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget cardButton(String imagePath, String title, String subtitle) {
  return SizedBox(
    height: 255,
    width: 162,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: backgroundWhite,
      elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32,),
            Image.asset(imagePath, width: 60, height: 60,),
            const SizedBox(height: 30,),
            Text(title, 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            const SizedBox(height: 5,),
            Text(subtitle, 
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: textGray, height: 1.8),),
          ],
                ),
        ),
    ),
  );
}