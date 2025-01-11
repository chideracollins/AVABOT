import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  int id;
  String title;
  String description;
  late double price;
  late double discountPrice;
  String image;
  
  int quantity = 1;
  bool addedToCart = false;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required double dollarPrice,
    required double dollarDiscountPrice,
    required this.image,
  }) {
    int rate = 1500;
    price = dollarPrice * rate;
    discountPrice = dollarDiscountPrice * rate;
  }

  int get discountPercentage {
    if (price < discountPrice) {
      return (((discountPrice - price) / discountPrice) * 100).toInt();
    }
    return (((price - discountPrice) / price) * 100).toInt();
  }

  double get quantityPrice {
    return quantity * price;
  }

  void incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (quantity == 1) return;
    quantity--;
    notifyListeners();
  }
}
