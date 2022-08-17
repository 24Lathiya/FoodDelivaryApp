import 'dart:convert';

import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cartList = [];
  List<String> cartHistoryList = [];

  void setCartList(List<CartModel> cartModelList) {
    cartList = [];
    // sharedpreferences store only sting list
    var time = DateTime.now().toString();
    cartModelList.forEach((element) {
      element.time = time;
      return cartList.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cartList);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    // getCartList();
  }

  List<CartModel> getCartList() {
    List<CartModel> cartModelList = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      var cart = sharedPreferences.getStringList(AppConstants.CART_LIST);
      // print(cart);
      cart!.forEach((element) {
        return cartModelList.add(CartModel.fromJson(jsonDecode(element)));
      });
    }
    // cartModelList.forEach((element) {
    //   print("=== ${element.name}");
    // });
    return cartModelList;
  }

  List<CartModel> getCartHistoryList() {
    List<CartModel> cartModelHistoryList = [];
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      var historyCart =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST);
      // print(historyCart);
      historyCart!.forEach((element) {
        return cartModelHistoryList
            .add(CartModel.fromJson(jsonDecode(element)));
      });
    }
    // cartModelHistoryList.forEach((element) {
    //   print("=== ${element.name}");
    // });
    return cartModelHistoryList;
  }

  void setCartHistoryList() {
    // add existing item list
    /*if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistoryList.addAll(
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!);
    }*/
    // add new item list
    cartHistoryList
        .addAll(sharedPreferences.getStringList(AppConstants.CART_LIST)!);
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistoryList);

    cartHistoryList.forEach((element) {
      print(element);
    });

    // remove item list from cart
    clearCart();
  }

  clearCart() {
    cartList = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  clearCartHistory() {
    clearCart();
    cartHistoryList = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
