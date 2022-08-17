// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/models/person_model.dart';
import 'package:food_delivery_app/pages/food/popular_food_details_page.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/utils/route_helper.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/food_details.dart';
import 'package:food_delivery_app/widgets/person_list.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(
      viewportFraction: 0.8); //0.8 for view some part of left n rigth item
  /*var imageList = [
    "food0.png",
    "food1.png",
    "food11.png",
    "food12.png",
    "food13.png",
    "food14.jpeg",
    "food15.jpeg",
  ];

  var titleList = [
    "food0 food0 food0 food0 food0",
    "food1 food1 food1 food1 food1",
    "food11 food11 food11 food11",
    "food12 food12 food12 food12",
    "food13 food13 food13 food13",
    "food14 food14 food14 food14",
    "food15 food15 food15 ",
  ];*/

  double gainStars = 4.0;
  var currentPage = 0.0;
  var scalFactor = 0.8;
  var height = Dimentions.imageContainerHeight;

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!;
        // print("===== $currentPage");
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  // color: Colors.grey,
                  height: Dimentions.containerHeight,
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          // Get.to(() => PopularFoodDetailsPage(results: popularProducts.popularProductList[index]));
                          // Get.toNamed(RouteHelper.popularFood);
                          Get.toNamed(RouteHelper.getPopularFood(index,"home"));
                          },
                        child: _slidePageItem(
                            index, popularProducts.popularProductList[index]),
                      );
                    },
                    itemCount: popularProducts.popularProductList.length,
                    controller: pageController,
                  ),
                )
              : Container(
                  height: Dimentions.containerHeight,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.mainColor,),
                  ),
                );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: currentPage,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeColor: AppColors.mainColor,
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: 10,
              ),
              SmallText(text: "."),
              SizedBox(
                width: 10,
              ),
              SmallText(text: "Food Pairing"),
            ],
          ),
        ),
        // FoodList(),
        PersonList(),
      ],
    );
  }

  Widget _slidePageItem(int index, Results results) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPage.floor()) {
      var currentScale = 1 - (currentPage - index) * (1 - scalFactor);
      var currentTrans = height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPage.floor() + 1) {
      var currentScale =
          scalFactor + (currentPage - index + 1) * (1 - scalFactor);
      var currentTrans = height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPage.floor() - 1) {
      var currentScale = 1 - (currentPage - index) * (1 - scalFactor);
      var currentTrans = height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      var currentTrans = height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: height,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: index.isEven ? Colors.yellow : Colors.green,
              image: DecorationImage(
                // image: AssetImage("assets/images/${imageList[index]}"),
                image: NetworkImage("${results.picture!.large}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.detailContainerHeight,
              width: double.maxFinite,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),
              child: Container(
                padding: EdgeInsets.all(12),
                child: FoodDetails(
                    foodTitle:
                        "${results.name!.title} ${results.name!.first} ${results.name!.last}",
                    gainStars: 4.0,
                    reviews: results.location!.postcode!,
                    foodType: "${results.location!.country}",
                    distance: "4.5km",
                    duration: "30min"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
