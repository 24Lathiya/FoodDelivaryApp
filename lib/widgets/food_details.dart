// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_text_row.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class FoodDetails extends StatelessWidget {
  String foodTitle;
  double gainStars;
  int reviews;
  String foodType;
  String distance;
  String duration;
  FoodDetails({
    Key? key,
    required this.foodTitle,
    required this.gainStars,
    required this.reviews,
    required this.foodType,
    required this.distance,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: foodTitle),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) {
                  return Icon(Icons.star_rate,
                      size: 15,
                      color: index < gainStars.toInt()
                          ? Color(0xFF89dad0)
                          : Colors.grey);
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "($gainStars)"),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "$reviews Reviews")
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconTextRow(
                icon: Icons.circle_sharp,
                color: AppColors.iconColor1,
                text: foodType),
            IconTextRow(
                icon: Icons.place, color: AppColors.mainColor, text: distance),
            IconTextRow(
                icon: Icons.access_time_rounded,
                color: AppColors.iconColor2,
                text: duration),
          ],
        ),
      ],
    );
  }
}
