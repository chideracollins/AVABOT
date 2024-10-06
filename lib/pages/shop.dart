import 'package:flutter/material.dart';

import '../widgets/shop_app_bar.dart';
import '../widgets/shop_body.dart';
import '../widgets/shop_drawer.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopAppBar(),
      drawer: ShopDrawer(),
      body: ShopBody(),
    );
  }
}
