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
    notifyListeners();
  }

  void removeFromCart(Product product) {
    products.remove(product);
    notifyListeners();
  }

  void clearCart() {
    products.clear();
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
