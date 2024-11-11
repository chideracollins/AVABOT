import 'package:flutter/material.dart';
import '../../utils/constants/images.dart';
import '../../widgets/dialogs/theme_dialog.dart';
import '../../widgets/dialogs/account_dialog.dart';

class ShopDrawer extends StatelessWidget {
  const ShopDrawer({super.key});

  void _showAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AccountDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const BeveledRectangleBorder(),
      child: Column(
        children: [
          // Header with logo and "New Chat" icon
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Images.logo,
                  width: 40.0,
                  height: 40.0,
                ),
                GestureDetector(
                  child: Image.asset(Images.newChatIcon),
                  onTap: () {
                    // Define the action for the "New Chat" icon
                  },
                ),
              ],
            ),
          ),
          const Divider(), // Divider between header and menu items

          // Card menu item
          ListTile(
            leading: Icon(Icons.credit_card,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            title: Text(
              'Card',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ), // Gray text color
            ),
            onTap: () {
              Navigator.pushNamed(context, "/card");
            },
          ),

          // Theme menu item
          ListTile(
            leading: Icon(
              Icons.color_lens,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            title: Text(
              'Theme',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ), // Gray text color
            ),
            onTap: () {
              showThemeSelectionModal(context);
            },
          ),

          // Account menu item
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            title: Text(
              'Account',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ), // Gray text color
            ),
            onTap: () {
              _showAccountDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
