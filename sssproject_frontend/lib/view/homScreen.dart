import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/view/cardButton.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) changeTab;

  const HomeScreen({super.key, required this.changeTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  child: Text('안녕하세요,\n구름이가\n도와드릴게요!', 
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    CardButton(
                      imagePath: 'assets/images/shieldSearchColor.png',
                      title: 'URL/번호 검색',
                      subtitle: '알 수 없는 URL이나\n번호를 검색할 수 있어요.', 
                      onTap:() => widget.changeTab(1),),
                    CardButton(
                      imagePath: 'assets/images/unlockColor.png',
                      title: '권한설정',
                      subtitle: '어플이 사용하는 권한을 한눈에 볼 수 있어요.', 
                      onTap:() => widget.changeTab(2)),
              ],
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    CardButton(
                      imagePath: 'assets/images/scanBarcodeColor.png',
                      title: '노이즈 추가',
                      subtitle: '사진에 노이즈를 추가하여 딥페이크를 방지해요.', 
                      onTap: () => widget.changeTab(3)),
                    CardButton(
                      imagePath: 'assets/images/alarmColor.png',
                      title: '신고 방법',
                      subtitle: '문제가 생겼을 때\n대처방법을 알아보아요.', 
                      onTap: () => widget.changeTab(4)),
              ],
            ),
            const SizedBox(height: 17,)
          ],
        ),
      ),
    );
  }
}
