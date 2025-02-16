import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/view/reportDetailScreen.dart';

class CardButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final int index;

  const CardButton({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 255,
      width: 162,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: backgroundWhite,
        elevation: 10.0,
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ReportDetailScreen(index: index)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Image.asset(imagePath, width: 60, height: 60),
                const SizedBox(height: 30),
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: textGray, height: 1.8)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}