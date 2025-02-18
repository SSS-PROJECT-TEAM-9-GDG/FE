import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/const/textstyle.dart';
import 'package:sssproject_frontend/view/cardButton.dart';
import 'package:sssproject_frontend/view/reportDetailScreen.dart';

class ReportHelperScreen extends StatefulWidget {

  const ReportHelperScreen({super.key});

  @override
  State<ReportHelperScreen> createState() => _ReportHelperScreenState();
}

void navigator (BuildContext context, int index) {
  Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ReportDetailScreen(index: index)));
}

class _ReportHelperScreenState extends State<ReportHelperScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundWhite,
      body: SafeArea(
        child: Container(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  const Padding(
                    padding: EdgeInsets.all(30),
                    child: Text('구름이와 함께\n대처방법을\n알아보아요!', 
                                style: dialogueStyle)),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/goormCharactor.png', 
                      width: size.width * 0.42, 
                      height:  size.height * 0.17,
                    ),
                  ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                        CardButton(
                          imagePath: 'assets/images/sadFaceColor.png',
                          title: '딥페이크',
                          subtitle: 'AI로 얼굴·음성을 조작해 사기·허위 정보 유포.🚫', 
                          onTap: () => navigator(context, 0),
                          ),
                        CardButton(
                          imagePath: 'assets/images/phoneColor.png',
                          title: '보이스피싱',
                          subtitle: '전화로 금융·공공기관 사칭, 돈·정보 요구 ⚠️', 
                          onTap: () => navigator(context, 1)),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                        CardButton(
                          imagePath: 'assets/images/smishingColor.png',
                          title: '스미싱',
                          subtitle: '문자로 악성 링크 유도, 개인정보 탈취 📩', 
                          onTap: () => navigator(context, 2)),
                        CardButton(
                          imagePath: 'assets/images/personalColor.png',
                          title: '개인정보 유출',
                          subtitle: '해킹·피싱으로 개인 정보가 노출 🛑', 
                          onTap: () => navigator(context, 3)),
                  ],
                ),
              ),
              const SizedBox(height: 17,)
            ],
          ),
        ),
      ),
    );
  }
}