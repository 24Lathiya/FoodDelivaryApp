import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_conroller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/route_helper.dart';
import 'package:food_delivery_app/utils/utils.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/no_data_page.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartHistoryPage extends StatelessWidget {
  // final String page;
  const CartHistoryPage({
    Key? key,
    /*required this.page*/
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var historyList = Get.find<CartController>()
        .cartRepo
        .getCartHistoryList()
        .reversed
        .toList();
    Map<String, int> cartPreOrderItems = Map();

    for (var element in historyList) {
      if (cartPreOrderItems.containsKey(element.time)) {
        cartPreOrderItems.update(element.time!, (value) => ++value);
      } else {
        cartPreOrderItems.putIfAbsent(element.time!, () => 1);
      }
    }

    List<String> cartOrderTimeList() {
      return cartPreOrderItems.entries.map((e) => e.key).toList();
    }

    List<String> orderTimes = cartOrderTimeList();

    List<int> cartOrderItemsList() {
      return cartPreOrderItems.entries.map((e) => e.value).toList();
    }

    List<int> orderItems = cartOrderItemsList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      return index < historyList.length
          ? BigText(text: "${Utils.formatDate(historyList[listCounter].time!)}")
          : BigText(text: "${DateTime.now()}");
    }

    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 45, left: 20, right: 20),
          color: AppColors.mainColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: "Order History",
                color: Colors.white,
              ),
              AppIcon(
                icon: Icons.shopping_cart,
                iconColor: Colors.white,
                bgColor: Colors.transparent,
              ),
            ],
          ),
        ),
        GetBuilder<CartController>(builder: (cartController) {
          return cartController.getCartHistoryList().isNotEmpty
              ? MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: ListView.builder(
                          itemCount: orderItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  timeWidget(listCounter),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                            orderItems[index], (index) {
                                          if (listCounter <
                                              historyList.length) {
                                            listCounter++;
                                          }

                                          return index < 3
                                              ? Container(
                                                  height: 80,
                                                  width: 80,
                                                  margin: EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            "${historyList[listCounter - 1].image}")),
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                )
                                              : Container();
                                        }),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SmallText(text: "Total"),
                                            BigText(
                                                text:
                                                    "${orderItems[index]} Items"),
                                            InkWell(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                      color:
                                                          AppColors.mainColor,
                                                      width: 1.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0,
                                                          right: 5.0),
                                                  child: SmallText(
                                                    text: "One More",
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                Map<int, CartModel> moreItems =
                                                    {};
                                                historyList.forEach((element) {
                                                  if (element.time ==
                                                      orderTimes[index]) {
                                                    print(
                                                        "order time : ${orderTimes[index]}");
                                                    moreItems.putIfAbsent(
                                                        element.id!,
                                                        () => CartModel.fromJson(
                                                            jsonDecode(
                                                                jsonEncode(
                                                                    element))));
                                                  }
                                                });
                                                Get.find<CartController>()
                                                    .setItems = moreItems;
                                                Get.find<CartController>()
                                                    .addToCartList();
                                                Get.toNamed(
                                                    RouteHelper.getCart());
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  alignment: Alignment.center,
                  child: const NoDataPage(text: "Cart history is Empty"));
        }),
      ],
    ));
  }
}
