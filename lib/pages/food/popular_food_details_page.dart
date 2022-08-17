// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_conroller.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/repository/cart_repo.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/utils/route_helper.dart';
import 'package:food_delivery_app/utils/utils.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text.dart';
import 'package:food_delivery_app/widgets/food_details.dart';
import 'package:get/get.dart';

class PopularFoodDetailsPage extends StatelessWidget {
  // final Results results;
  final int index;
  final String page;
  PopularFoodDetailsPage({
    Key? key,
    required this.index,
    required this.page,
    /*required this.results*/
  }) : super(key: key);

  var gainStars = 4.0;

  @override
  Widget build(BuildContext context) {
    var results =
        Get.find<PopularProductController>().popularProductList[index];
    var price = results.dob!.age!.toDouble();

    Get.find<PopularProductController>()
        .initProduct(results, Get.find<CartController>());

    return Scaffold(
      body: Container(
        //mendatory container otherwise stack will not overlap like framelayout
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: Dimentions.foodContainerHeight,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      // image: AssetImage("assets/images/food0.png"),
                      image: NetworkImage(results.picture!.large!),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: AppIcon(icon: Icons.arrow_back_ios),
                    onTap: () {
                      if (page == "cart") {
                        Get.toNamed(RouteHelper.getCart());
                      } else {
                        //  Get.toNamed(RouteHelper.initial);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  GetBuilder<PopularProductController>(
                      builder: (popularProductController) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCart());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart),
                          popularProductController.totalQuantity > 0
                              ? Positioned(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.mainColor,
                                    ),
                                    child: Text(
                                      "${popularProductController.totalQuantity}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                  ),
                                  right: 0,
                                  top: 0,
                                )
                              : Container(),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimentions.foodContainerHeight - 20,
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoodDetails(
                          foodTitle:
                              "${results.name!.first} ${results.name!.last}",
                          gainStars: 4.0,
                          reviews: 1250,
                          foodType: "Normal",
                          distance: "2.5km",
                          duration: "30min"),
                      SizedBox(
                        height: 10,
                      ),
                      BigText(
                        text: "Introduce",
                        size: 18,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // SmallText(text: "Description of pages.food"),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableText(
                              text:
                                  "qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,"),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProductController) {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: AppColors.buttonBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                        onTap: () {
                          popularProductController.setQuantity(false);
                        },
                      ),
                      BigText(text: "${popularProductController.inCartItems}"),
                      InkWell(
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                        onTap: () {
                          popularProductController.setQuantity(true);
                        },
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProductController.addItem(results);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text:
                          "\$ ${Utils.getRoundDouble(price * popularProductController.inCartItems)} | Add to Cart",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
