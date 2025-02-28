import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/images.dart';
import 'package:sssproject_frontend/const/textstyle.dart';
import 'package:sssproject_frontend/phone/dio/PhoneNumber.dart';

Widget phoneResultWidget(PhoneNumber phoneData, BuildContext context) {
  final Size size = MediaQuery.of(context).size;

  return Column(
      children: [
        Container(
          height: size.height*0.5,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  gooroomCharactor2,
                  width: 210,
                  height: 180,
                ),
                const SizedBox(height: 10),
                Text(
                  phoneData.spam == "" ? "✅ 안심할 수 있는 번호에요!" : "🚫 안전하지 않은 전화번호에요!",
                  style: megaTitleStyle
                ),
                const SizedBox(height: 10),
                Text(
                  phoneData.spam == "" ?
                  "최근 3개월 내에\n3건 이상 접수된 민원이 없어요. " 
                  : "${phoneData.spamCount}회 이상 신고가 된 번호에요.\n신뢰할 수 없는 전화번호이므로\n주의 해야 해요.",
                  style: resultBodyStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],
            ),
        ),
      ],
    );
}