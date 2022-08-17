import 'package:food_delivery_app/models/person_model.dart';

class CartModel {
  int? id;
  String? name;
  double? price;
  String? image;
  int? quantity;
  bool? isExist;
  String? time;
  Results? results;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.image,
      this.quantity,
      this.isExist,
      this.time,
      this.results});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    quantity = json['quantity'];
    isExist = json['isexist'];
    time = json['time'];
    results = Results.fromJson(json['results']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['isExist'] = this.isExist;
    data['time'] = this.time;
    data['results'] = this.results;
    return data;
  }
}
