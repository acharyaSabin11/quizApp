import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color textColor;
  final FontWeight fontWeight;
  const CustomText(
      {super.key,
      required this.text,
      this.size = 24,
      this.textColor = const Color(0xFFFFFFFF),
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Roboto",
        fontSize: size,
        fontWeight: fontWeight,
        color: textColor,
      ),
    );
  }
}
