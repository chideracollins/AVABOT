import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  int id;
  String title;
  String description;
  double price;
  double discountPrice;
  String image;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.discountPrice,
      required this.image});
}
