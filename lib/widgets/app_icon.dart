import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  IconData icon;
  Color iconColor;
  Color bgColor;
  double iconSize;
  double size;
  AppIcon({
    Key? key,
    required this.icon,
    this.iconColor = const Color(0xFF756d54),
    this.bgColor = const Color(0xFFfef4e4),
    this.size = 40,
    this.iconSize = 16
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: bgColor,
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}
