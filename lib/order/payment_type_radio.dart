import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_conroller.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

class PaymentTypeRadio extends StatelessWidget {
  final int index;
  final String title;

  const PaymentTypeRadio({Key? key, required this.index, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartControler) {
      return InkWell(
        onTap: () {
          cartControler.setPaymentTypeIndex(index);
        },
        child: Container(
          child: ListTile(
            leading: cartControler.paymentTypeIndex == index
                ? Icon(
                    Icons.radio_button_checked_rounded,
                    color: AppColors.mainColor,
                  )
                : Icon(Icons.radio_button_off_outlined),
            title: Text(title),
          ),
        ),
      );
    });
  }
}
