import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_conroller.dart';
import 'package:food_delivery_app/models/person_model.dart';
import 'package:food_delivery_app/repository/recommended_product_repo.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<Results> _recommendedProductList = [];
  List<Results> get recommendedProductList => _recommendedProductList;

  late CartController _cartController;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      // print("get data");
      // _recommendedProductList = [];
      _recommendedProductList.addAll(Persons.fromJson(response.body).results!);
      //    Persons.fromJson(response.body).results!.clear();

      update(); //work like set state
    } else {
      print("something went wrong");
    }
  }

  void clearRecommendedProductList() {
    _recommendedProductList.clear();
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
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
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

  int get totalQuantity {
    return _cartController.totalQuantity;
  }
}
