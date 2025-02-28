import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/const/textstyle.dart';

class CardButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CardButton({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onTap
  });
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.28,
      width: size.width * 0.42,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: backgroundWhite,
        elevation: 10.0,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(imagePath, width: size.height * 0.067, height: size.height * 0.067),
                Text(title, style: cardTitleStyle),
                Text(subtitle, style: cardDecStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}