import 'package:flutter/material.dart';

import '../pages/shop.dart';

class ShopDrawer extends StatelessWidget {
  const ShopDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: const BeveledRectangleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
                child: Row(
                  children: [
                    Image.asset("assets/images/Main-Logo.png"),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                      child: Text('New Chat'),
                    ),
                    const Spacer(),
                    GestureDetector(
                      child: Image.asset("assets/images/New-Chat.png"),
                      onTap: () {
                        return ShopPage();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: searches.isNotEmpty == true
                    ? ListView(
                        // padding: EdgeInsets.zero,
                        children: <Widget>[
                          const Text(
                            "Today",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          for (var _ in searches.keys.toList().reversed)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                searches[_]![0],
                                softWrap: true,
                                textDirection: TextDirection.ltr,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                setState(
                                  () {
                                    aiReply = searches[_]![1];
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Message Ava !!!",
                            style: TextStyle(
                              color: _greenAccent,
                              fontSize: 16.0,
                            ),
                          ),
                          const Text("Previous message logs appears here..."),
                        ],
                      ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "/account"),
                        child: ClipOval(
                          child: CircleAvatar(
                            child: Image.asset("assets/images/Main-Logo.png"),
                          ),
                        ),
                      ),
                    ),
                    const Text("Wisdom Ahaneku"),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}