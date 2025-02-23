import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/images.dart';
import 'package:sssproject_frontend/const/textstyle.dart';

Widget errorWidget(BuildContext context) {
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
                const Text(
                  "🤔 검색할 수 없는 정보에요!",
                  style: megaTitleStyle
                ),
                const SizedBox(height: 10),
                const Text(
                  "올바르게 입력했는지 확인 후\n다시 시도해주세요.",
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