import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/view/cardButton.dart';

class ReportHelperScreen extends StatefulWidget {

  const ReportHelperScreen({super.key});

  @override
  State<ReportHelperScreen> createState() => _ReportHelperScreenState();
}

class _ReportHelperScreenState extends State<ReportHelperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(backgroundColor: backgroundWhite,),
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
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text('함께 대처방법을\n알아보아요!', 
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/goormCharactor.png', 
                    width: 141, 
                    height: 148,
                  ),
                ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    CardButton(
                      imagePath: 'assets/images/sadFaceColor.png',
                      title: '딥페이크',
                      subtitle: 'AI로 얼굴·음성을 조작해 사기·허위 정보 유포.🚫', 
                      index: 0,),
                    CardButton(
                      imagePath: 'assets/images/phoneColor.png',
                      title: '보이스피싱',
                      subtitle: '전화로 금융·공공기관 사칭, 돈·정보 요구 ⚠️', 
                      index: 1,),
              ],
            ),
            const SizedBox(height: 16,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    CardButton(
                      imagePath: 'assets/images/smishingColor.png',
                      title: '스미싱',
                      subtitle: '문자로 악성 링크 유도, 개인정보 탈취 📩', 
                      index: 2,),
                    CardButton(
                      imagePath: 'assets/images/personalColor.png',
                      title: '개인정보 유출',
                      subtitle: '해킹·피싱으로 개인 정보가 노출 🛑', 
                      index: 3,),
              ],
            ),
            const SizedBox(height: 17,)
          ],
        ),
      ),
    );
  }
}