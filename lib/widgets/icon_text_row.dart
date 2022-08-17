// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class IconTextRow extends StatelessWidget {
  IconData icon;
  Color color;
  String text;
  IconTextRow({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(text: text)
      ],
    );
  }
}
