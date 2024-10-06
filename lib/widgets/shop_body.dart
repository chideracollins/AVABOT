import "package:flutter_markdown/flutter_markdown.dart";
import 'package:flutter/material.dart';

import '../utils/constants/images.dart';

class ShopBody extends StatefulWidget {
  const ShopBody({super.key});

  @override
  State<ShopBody> createState() => _ShopBodyState();
}

class _ShopBodyState extends State<ShopBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          children: [
            aiReply?.isNotEmpty == true
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: CircleAvatar(
                                  child: Image.asset(
                                    Images.launcherIcon,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 12.0, 0.0, 0.0),
                                child: Text(
                                  "Avabot",
                                  style: TextStyle(
                                    color: _greenAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(52.0, 24.0, 0.0, 0.0),
                            child: Expanded(
                              child: MarkdownBody(
                                data: aiReply!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Icon.png"),
                        Text.rich(
                          TextSpan(
                            text: "Hi Wisdom, I'm ",
                            children: [
                              TextSpan(
                                text: "Ava!",
                                style: TextStyle(
                                  color: _greenAccent,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Your ",
                            children: [
                              TextSpan(
                                text: "AI assistant ",
                                style: TextStyle(
                                  color: _greenAccent,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    "for you seamless online shopping experience. I'm glad you are here. ",
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Welcome to Avabot!",
                          style: TextStyle(
                            color: _greenAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
            TextField(
              controller: _textEditingController,
              // autofocus: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Message Ava...",
                enabled: _enableInputBox,
                suffixIcon: IconButton(
                  onPressed: () async {
                    if (_textEditingController.text.length < 2) return;
                    setState(() {
                      _enableInputBox = false;
                    });
                    aiReply =
                        (await generateAiReply(_textEditingController.text))
                            .toString();
                    setState(
                      () {
                        searches[generateId()] = [
                          _textEditingController.text,
                          aiReply!
                        ];
                        _textEditingController.clear();
                        _enableInputBox = true;
                      },
                    );
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.elliptical(4.0, 4.0),
                      ),
                      gradient: LinearGradient(
                        colors: [_blueAccent, _greenAccent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Image.asset("assets/images/Send.png"),
                  ),
                ),
              ),
              showCursor: true,
            ),
          ],
        ),
      ),
    );
  };
  }
}