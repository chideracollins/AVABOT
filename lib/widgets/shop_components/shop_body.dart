import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../models/shopping_session.dart';
import '../chat_interface.dart';
import '../default_shop_interface.dart';
import '../shop_input.dart';

class ShopBody extends StatefulWidget {
  const ShopBody({super.key});

  @override
  State<ShopBody> createState() => _ShopBodyState();
}

class _ShopBodyState extends State<ShopBody> {
  User? get user => FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        children: [
          Provider.of<ShoppingSession>(context).hastStarted
              ? const ChatInterface()
              : const DefaultShopInterface(),
          const ShopInput(),
        ],
      ),
    );
  }
}
