import 'package:flutter/material.dart';
import 'product.dart';
import '../pages/payment.dart';

class ShoppingCart extends ChangeNotifier {
  List<Product> products = [];

  String get count => products.length.toString();

  double get totalAmount {
    return products.fold(0.0, (sum, product) => sum + product.quantityPrice);
  }

  void addToCart(Product product) {
    products.add(product);
    product.addedToCart = true;
    notifyListeners();
  }

  void removeFromCart(Product product) {
    products.remove(product);
    product.addedToCart = false;
    notifyListeners();
  }

  void clearCart() {
    products.clear();
    for (var product in products) {
      product.addedToCart = false;
    }
    notifyListeners();
  }

  void pay(BuildContext context) {
    if (products.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cart is empty! Add items to proceed.")),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(totalAmount),
      ),
    );
  }
}
