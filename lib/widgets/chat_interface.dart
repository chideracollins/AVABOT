import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shopping_session.dart';
import 'ai_reply.dart';
import 'user_message.dart';

class ChatInterface extends StatefulWidget {
  const ChatInterface({super.key});

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Provider.of<ShoppingSession>(context).history.length,
        itemBuilder: (context, index) {
          List chatHistorykeys =
              Provider.of<ShoppingSession>(context).history.keys.toList();
          List chatHistoryValues =
              Provider.of<ShoppingSession>(context).history.values.toList();
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [UserMessage(chatHistorykeys[index].question!)],
              ),
              AiReply(chatHistoryValues[index]),
            ],
          );
        },
      ),
    );
  }
}
