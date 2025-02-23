import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/images.dart';
import 'package:sssproject_frontend/const/textstyle.dart';
import 'package:sssproject_frontend/url/model/Url.dart';

Widget urlResultWidget(Url urldata, BuildContext context) {
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
                  !urldata.malicious ? "✅ 안심할 수 있는 URL이에요!" : "🚫 의심스러운 URL이에요!",
                  style: megaTitleStyle
                ),
                const SizedBox(height: 10),
                Text(
                  !urldata.malicious ? 
                  "악성으로 판단되지 않은 url이에요.\n안심하고 접속할 수 있어요." 
                  : "${urldata.maliciousCount}번 악성으로 판정된 url이에요.\n접속할 때 주의가 필요해요.",
                  style: resultBodyStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "url 안정성 판정은 ~~~api를 통해서 이루어져요.\nurl를 악성으로 판정한 안티바이러스엔진이나 보안 업체의 개수를 제공하고 있어요.",
                  style: referenceStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
        ),
      ],
    );
}