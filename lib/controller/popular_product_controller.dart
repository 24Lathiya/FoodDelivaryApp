import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_conroller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/person_model.dart';
import 'package:food_delivery_app/repository/popular_product_repo.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<Results> _popularProductList = [];

  List<Results> get popularProductList => _popularProductList;

  late CartController _cartController;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    print("api calling");
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      // print("get data");
      _popularProductList = [];
      _popularProductList.addAll(Persons.fromJson(response.body).results!);
      _isLoaded = true;
      update(); //work like set state
    } else {
      print("something went wrong");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    print("==== $_quantity");
    update();
  }

  int checkQuantity(int quantity) {
    if ((quantity + _inCartItems) < 0) {
      Get.snackbar("Item Count", "You can't remove more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if(_inCartItems > 0){
        _quantity = - _inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((quantity + _inCartItems) > 10) {
      Get.snackbar("Item Count", "You can't add more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 10;
    } else {
      return quantity;
    }
  }

  void initProduct(Results results, CartController cartController) {
    _quantity = 0;
    _cartController = cartController;
    _inCartItems = _cartController.getQuantity(results);
    // print("===inCartItems===: $_inCartItems");
  }

  void addItem(Results results) {
    // print("add item : ${results.name!.first}");
    _cartController.addItem(results, _quantity);
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(results);
     update();
  }

  int get totalQuantity{
    return _cartController.totalQuantity;
  }

  List<CartModel> get totalItems{
    return _cartController.totalItems;
  }
}
