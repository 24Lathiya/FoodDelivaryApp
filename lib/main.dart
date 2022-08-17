import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_conroller.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/route_helper.dart';
import 'package:get/get.dart';

import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // UserPreferences.sharedPreferences = await SharedPreferences.getInstance();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var cartList =
        Get.find<CartController>().getCartList(); // get data from shared list
    // print("${cartList.first.name}");
    return GetBuilder<PopularProductController>(builder: (_) {
      // return GetBuilder<RecommendedProductController>(builder: (_){
      return GetBuilder<CartController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.APP_NAME,
          // home: const SignInPage(),
          initialRoute: RouteHelper.splash,
          getPages: RouteHelper.routes,
        );
      });
      // });
    });
  }
}
