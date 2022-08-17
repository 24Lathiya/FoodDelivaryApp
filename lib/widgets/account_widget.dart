import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  final AppIcon appIcon;
  final BigText bigText;
  const AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              appIcon,
              SizedBox(
                width: 20,
              ),
              bigText,
            ],
          ),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 2.0),
              blurRadius: 1.0,
              color: Colors.grey.withOpacity(0.2),
            ),
          ]),
        ),
      ],
    );
  }
}
