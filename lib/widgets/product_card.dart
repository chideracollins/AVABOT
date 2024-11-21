import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/constants/colors.dart';

class ProductCard extends StatefulWidget {
  final List<Product>? products;

  const ProductCard(this.products, {super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.products != null) {
      List<Product> products = widget.products!;
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.products?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  height: 280,
                  width: 200,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            products[index].image,
                            height: 140,
                            width: 200,
                          ),
                          Positioned(
                            right: 4,
                            top: 2,
                            child: Container(
                              height: 24,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: Text(
                                "-${products[index].discountPercentage}%",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 140,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            gradient: AppColors.cardLinearGradient),
                        child: Column(
                          children: [
                            Text(
                              products[index].title,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("\$${products[index].price}"),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Center(child: Text("Add to Cart")),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      return const SizedBox.shrink();
    }
  }
}
