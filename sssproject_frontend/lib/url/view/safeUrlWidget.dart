import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/images.dart';
import 'package:sssproject_frontend/url/model/Url.dart';

Widget safeUrlWidget(Url urldata) {
  return Column(
    children: [
      const SizedBox(height: 20),
      Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              gooroomCharactor2,
              width: 210,
              height: 180,
            ),
            const SizedBox(height: 10),
            Text(
              urldata.malicious ? "✅안심할 수 있는 URL이에요! ${urldata.url}" : "🚫의심스러운 URL이에요!",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "최근 3개월 내에${urldata.maliciousCount}건 이상 접수된 민원이 없어요.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    ],
  );
}