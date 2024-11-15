import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/shopping_cart.dart';
import '../../utils/constants/images.dart';

class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Image(
              image: AssetImage(Images.menuIcon),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(Images.logoWithName),
        ],
      ),
      actions: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
              child: GestureDetector(
                child: Image.asset(Images.shoppingCartIcon),
                onTap: () {
                  Navigator.pushNamed(context, "/cart");
                },
              ),
            ),
            Positioned(
              right: 12,
              top: -4,
              child: Consumer<ShoppingCart>(
                builder: (context, cart, child) {
                  return Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.count,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
