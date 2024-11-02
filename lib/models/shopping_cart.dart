import 'package:flutter/material.dart';

import 'product.dart';

class ShoppingCart extends ChangeNotifier {
  List<Product>? products;

  String count() {
    return products?.length.toString() ?? "0";
  }

  void addToCart(Product product) {
    products = [product, ...?products];
  }

  void pay() {}
}
