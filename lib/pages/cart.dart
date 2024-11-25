import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shopping_cart.dart';
import '../utils/constants/colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final shoppingCart = Provider.of<ShoppingCart>(context);
    final products = shoppingCart.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: products.isEmpty
                ? const Center(
                    child: Text(
                      "The cart is empty",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  product.image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        product.description,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                product.decrementQuantity();
                                              });
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text(
                                            '${product.quantity}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                product.incrementQuantity();
                                              });
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  children: [
                                    Text(
                                      "₦${product.price * product.quantity}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    IconButton(
                                      onPressed: () {
                                        shoppingCart.removeFromCart(product);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("Item removed from cart"),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (index < products.length - 1)
                              const Divider(
                                color: Colors.grey,
                                height: 32,
                                thickness: 1,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Total: ₦${shoppingCart.totalAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonLinearGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      shoppingCart.pay(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
