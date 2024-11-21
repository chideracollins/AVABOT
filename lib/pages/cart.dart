import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:pay_with_paystack/pay_with_paystack.dart';

import '../utils/constants/colors.dart';
// import '../widgets/dialogs/failure_dialog.dart';
// import '../widgets/dialogs/success_dialog.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Product 1',
      'description': 'This is a short description of product 1.',
      'price': 5000,
      'image': 'assets/images/cart-image-1.jpg',
      'quantity': 1,
    },
    {
      'title': 'Product 2',
      'description': 'This is a short description of product 2.',
      'price': 3000,
      'image': 'assets/images/cart-image-2.jpg',
      'quantity': 1,
    },
    {
      'title': 'Product 3',
      'description': 'This is a short description of product 3.',
      'price': 8000,
      'image': 'assets/images/cart-image-1.jpg',
      'quantity': 1,
    },
  ];

  double get totalAmount {
    return products.fold(
        0, (sum, product) => sum + product['quantity'] * product['price']);
  }

  void _processPayment() {
    final secretKey = dotenv.env['PAYSTACK_SECRET_KEY'];
    // final uniqueTransRef = PayWithPayStack().generateUuidV4();
    final userEmail = FirebaseAuth.instance.currentUser?.email;

    if (secretKey == null || userEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment configuration error")),
      );
      return;
    }

    // PayWithPayStack().now(
    //   context: context,
    //   secretKey: secretKey,
    //   customerEmail: userEmail,
    //   reference: uniqueTransRef,
    //   currency: "NGN",
    //   paymentChannel: ["card"],
    //   amount: totalAmount.toInt() * 100,
    //   callbackUrl: "",
    //   transactionCompleted: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const SuccessDialog(),
    //       ),
    //     );
    //   },
    //   transactionNotCompleted: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const FailureDialog(),
    //       ),
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(products.length, (index) {
                  final product = products[index];
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            product['image'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product['description'],
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
                                          if (product['quantity'] > 1) {
                                            product['quantity']--;
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      '${product['quantity']}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          product['quantity']++;
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
                                "₦${product['quantity'] * product['price']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    products.removeAt(index);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Item removed from cart"),
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
                }),
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
                    "Total: ₦${totalAmount.toStringAsFixed(2)}",
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
                      _processPayment();
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
