import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/shopping_cart.dart';
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
      return SizedBox(
        height: 280,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.products?.length,
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              margin: const EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondary,
                    offset: Offset.fromDirection(1),
                    blurRadius: 2,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
              ),
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
                        right: 6,
                        top: 6,
                        height: 24,
                        width: 56,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Text(
                            "-${products[index].discountPercentage}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              decorationStyle: TextDecorationStyle.dashed,
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
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        gradient: AppColors.cardLinearGradient),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Text(
                                    products[index].description,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "₦${products[index].price}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Consumer<ShoppingCart>(
                            builder: (context, cart, child) {
                              return GestureDetector(
                                onTap: () {
                                  if (products[index].addedToCart) {
                                    cart.removeFromCart(products[index]);
                                  } else {
                                    cart.addToCart(products[index]);
                                  }
                                  setState(() {
                                    products[index].addedToCart =
                                        !products[index].addedToCart;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding:
                                      const EdgeInsets.only(bottom: 4, top: 4),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    products[index].addedToCart == false
                                        ? "Add to Cart"
                                        : "Remove from Cart",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
