// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color color;
  double size;
  TextOverflow textOverflow;
  BigText(
      {Key? key,
      required this.text,
      this.color = const Color(0xFF332d2b),
      this.size = 20,
      this.textOverflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: size,
      ),
    );
  }
}
