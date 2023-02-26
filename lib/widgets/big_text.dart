import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final Color textColor;
  const BigText({
    super.key,
    required this.text,
    this.size = 24,
    this.textColor = const Color(0xFFFFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontFamily: "Roboto",
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}
