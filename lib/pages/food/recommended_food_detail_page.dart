import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_conroller.dart';
import 'package:food_delivery_app/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/route_helper.dart';
import 'package:food_delivery_app/utils/utils.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetailPage extends StatelessWidget {
  final int index;
  final String page;
  const RecommendedFoodDetailPage({
    Key? key,
    required this.index,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var results =
        Get.find<RecommendedProductController>().recommendedProductList[index];
    var price = results.dob!.age!.toDouble();
    Get.find<RecommendedProductController>()
        .initProduct(results, Get.find<CartController>());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 300,
            backgroundColor: AppColors.mainColor,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: AppIcon(
                    icon: Icons.close,
                    size: 30,
                  ),
                  onTap: () {
                    // Get.toNamed(RouteHelper.initial);
                    Navigator.of(context).pop();
                  },
                ),
                GetBuilder<RecommendedProductController>(
                    builder: (recommendedProductController) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getCart());
                    },
                    child: Stack(
                      children: [
                        AppIcon(
                          icon: Icons.shopping_cart,
                          size: 30,
                        ),
                        recommendedProductController.totalQuantity > 0
                            ? Positioned(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.mainColor,
                                  ),
                                  child: Text(
                                    "${recommendedProductController.totalQuantity}",
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
            flexibleSpace: FlexibleSpaceBar(
              // background: Image.asset("assets/images/food0.png",
              background: Image.network(
                results.picture!.large!,
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  child: Center(
                    child: BigText(
                        text:
                            results.name!.title! + " " + results.name!.first!),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
                preferredSize: const Size.fromHeight(20)),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // child: Text("qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,"),
              child: ExpandableText(
                  text:
                      "qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm,qwertyuiop[asdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjklzxcvbnm"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<RecommendedProductController>(
          builder: (recommendedProductController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: AppIcon(
                      icon: Icons.remove,
                      iconSize: 24,
                      iconColor: Colors.white,
                      bgColor: AppColors.mainColor,
                    ),
                    onTap: () {
                      recommendedProductController.setQuantity(false);
                    },
                  ),
                  BigText(
                      text:
                          "\S $price X ${recommendedProductController.inCartItems}"),
                  InkWell(
                    child: AppIcon(
                      icon: Icons.add,
                      iconSize: 24,
                      iconColor: Colors.white,
                      bgColor: AppColors.mainColor,
                    ),
                    onTap: () {
                      recommendedProductController.setQuantity(true);
                    },
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        recommendedProductController.addItem(results);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: AppColors.mainColor,
                        ),
                        child: BigText(
                          text:
                              "\$ ${Utils.getRoundDouble(price * recommendedProductController.inCartItems)} | Add to Cart",
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
