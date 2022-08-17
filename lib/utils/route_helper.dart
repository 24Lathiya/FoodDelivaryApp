import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_details_page.dart';
import 'package:food_delivery_app/pages/food/recommended_food_detail_page.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/splash/splash_screen_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splash = "/splash";
  static String getSplash() => "$splash";
  static const String signin = "/signin";
  static String getSignIn() => "$signin";
  static const String signup = "/signup";
  static String getSignUp() => "$signup";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static String getPopularFood(int index, String page) =>
      "$popularFood?index=$index&page=$page";
  static const String recommendedFood = "/recommended-food";
  static String getRecommendedFood(int index, String page) =>
      "$recommendedFood?index=$index&page=$page";
  static const String cart = "/cart";
  static String getCart() => "$cart";

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreenPage()),
    GetPage(name: "/", page: () => HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var index = Get.parameters['index'];
          var page = Get.parameters['page'];
          return PopularFoodDetailsPage(
            index: int.parse(index!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var index = Get.parameters['index'];
          print("===== $index");
          var page = Get.parameters['page'];
          return RecommendedFoodDetailPage(
            index: int.parse(index!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    //cart
    GetPage(
        name: cart,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    //sign in
    GetPage(
        name: signin,
        page: () {
          return SignInPage();
        },
        transition: Transition.fadeIn),
    //sign up
    GetPage(
        name: signup,
        page: () {
          return SignUpPage();
        },
        transition: Transition.fadeIn),
  ];
}
