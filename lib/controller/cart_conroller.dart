import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/person_model.dart';
import 'package:food_delivery_app/repository/cart_repo.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  var _paymentIndex = 0;
  get paymentIndex => _paymentIndex;

  var _paymentTypeIndex = 0;
  get paymentTypeIndex => _paymentTypeIndex;

  var _foodNote = "";
  get foodNote => _foodNote;

  void addItem(Results results, int quantity) {
    // print("item add to cart controller ${results.name!.first}");
    var totalQuantity = 0;
    var id = results.location!.street!.number;
    if (_items.containsKey(id)) {
      _items.update(id!, (value) {
        print("product updated id: $id and quantity: $quantity");
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          image: value.image,
          quantity: totalQuantity,
          isExist: value.isExist,
          time: value.time,
          results: results,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(id!, () {
          print("product added id: $id and quantity: $quantity");
          return CartModel(
            id: id,
            name: results.name!.first,
            price: results.dob!.age!.toDouble(),
            image: results.picture!.large,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            results: results,
          );
        });
      } else {
        Get.snackbar("Quantity", "Add Item First",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    _items.forEach((key, value) {
      print("id : $key quantity : ${value.quantity}");
    });
    addToCartList();
  }

  bool existInCart(Results results) {
    if (_items.containsKey(results.location!.street!.number)) {
      return true;
    }
    return false;
  }

  int getQuantity(Results results) {
    int quantity = 0;
    if (existInCart(results)) {
      _items.forEach((key, value) {
        if (key == results.location!.street!.number) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalQuantity {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity!;
    });
    return total;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    return total;
  }

  List<CartModel> get totalItems {
    return _items.entries.map((e) => e.value).toList();
  }

  List<CartModel> cartList = [];

  List<CartModel> getCartList() {
    setCartList = cartRepo.getCartList();
    return cartList;
  }

  set setCartList(List<CartModel> list) {
    cartList = list;
    cartList.forEach((element) {
      _items.putIfAbsent(element.id!, () => element);
    });
  }

  void addToHistory() {
    cartRepo.setCartHistoryList();
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> items) {
    _items = {};
    _items = items;
  }

  void addToCartList() {
    cartRepo.setCartList(totalItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }

  void setPaymentIndex(int index) {
    _paymentIndex = index;
    update();
  }

  void setPaymentTypeIndex(int index) {
    _paymentTypeIndex = index;
    update();
  }

  void setFoodNote(String note) {
    _foodNote = note;
    // update();
  }
}
