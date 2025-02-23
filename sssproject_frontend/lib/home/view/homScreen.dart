import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/const/images.dart';
import 'package:sssproject_frontend/const/textstyle.dart';
import 'package:sssproject_frontend/util/view/cardButton.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) changeTab;

  const HomeScreen({super.key, required this.changeTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
  final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundWhite,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundCurve),
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
                    child: Text('안녕하세요,\n구름이가\n도와드릴게요!', 
                                style: dialogueStyle,)),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      goormCharactor, 
                      width: size.height * 0.17, 
                      height: size.height * 0.17,
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
                          imagePath: linkColor,
                          title: 'URL검색',
                          subtitle: '알 수 없는 URL을 검색할 수 있어요.🔎', 
                          onTap:() => widget.changeTab(0),),
                        CardButton(
                          imagePath: callSlash,
                          title: '전화번호 검색',
                          subtitle: '알 수 없는 전화번호를 검색할 수 있어요.🔎', 
                          onTap:() => widget.changeTab(1)),
                  ],
                ),
              ),
        
              Expanded (
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                        CardButton(
                          imagePath: scanBarcodeColor,
                          title: '노이즈 추가',
                          subtitle: '사진에 노이즈를 추가하여 딥페이크를 방지해요.🙅‍♀️', 
                          onTap: () => widget.changeTab(3)),
                        CardButton(
                          imagePath: alarmColor,
                          title: '신고 방법',
                          subtitle: '문제가 생겼을 때 대처방법을 알아볼 수 있어요.💡', 
                          onTap: () => widget.changeTab(4)),
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
