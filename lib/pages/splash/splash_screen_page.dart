import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/utils/route_helper.dart';
import 'package:get/get.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  Future<void> _loadingData() async {
    await Get.find<PopularProductController>().getPopularProductList();
    // await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    _loadingData();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);

    Timer(Duration(seconds: 3), () {
      Get.offNamed(RouteHelper.initial);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ScaleTransition(
                  scale: animation,
                  child: Image.asset("assets/images/logo_part_1.png")),
            ),
            Image.asset("assets/images/logo_part_2.png"),
          ],
        ),
      ),
    );
  }
}
