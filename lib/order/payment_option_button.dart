import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_conroller.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class PaymentOptionButton extends StatelessWidget {
  final int index;
  final IconData icon;
  final String title;
  final String subTitle;
  const PaymentOptionButton({
    Key? key,
    required this.index,
    required this.icon,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      return InkWell(
        onTap: () {
          // print("===index=== $index");
          cartController.setPaymentIndex(index);
        },
        child: Container(
          margin: EdgeInsets.only(top: 5, left: 15, right: 15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(15.0)),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: cartController.paymentIndex == index
                  ? AppColors.mainColor
                  : Theme.of(context).disabledColor,
            ),
            title: BigText(text: title),
            subtitle: SmallText(text: subTitle),
            trailing: Icon(
              Icons.check_circle,
              color: cartController.paymentIndex == index
                  ? AppColors.mainColor
                  : Colors.white,
            ),
          ),
        ),
      );
    });
  }
}
