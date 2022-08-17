// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color color;
  double size;
  double heigth;
  SmallText({
    Key? key,
    required this.text,
    this.color = Colors.black54,
    this.size = 14,
    this.heigth = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: size,
        height: heigth,
      ),
    );
  }
}
