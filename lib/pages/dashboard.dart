import "package:google_generative_ai/google_generative_ai.dart";
import "package:flutter_markdown/flutter_markdown.dart";

import "package:flutter/material.dart";

int questionAnswerId = 0;
const apiKey = "AIzaSyDTwm_NNQo82hGlr8juULY5ee7uYrHHhYU";
final Map<int, List<String>> searches = {};
String? aiReply;

int generateId() {
  return questionAnswerId++;
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // String? _recentQuery;
  final _textEditingController = TextEditingController();
  final Color _greenAccent = const Color.fromARGB(255, 64, 160, 69);
  final Color _blueAccent = const Color.fromARGB(255, 26, 58, 86);
  bool _enableInputBox = true;

  Future<String?> generateAiReply(String question) async {
    final model =
        GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: apiKey);
    final content = [Content.text(question)];
    try {
      final response = await model.generateContent(content);
      return response.text;
    } on Exception catch (e) {
      return "Sorry we couldn't access Gemini due to this error '${e.runtimeType}', check your internet connection and try again.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Image(
                image: AssetImage("assets/images/Menu.png"),
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
            Image.asset("assets/images/Logo.png"),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
            child: GestureDetector(
              child: Image.asset("assets/images/Basket.png"),
              onTap: () {
                Navigator.pushNamed(context, "/shop");
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
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
                        aiReply = null;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Dashboard(),
                          ),
                        );
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
      ),
      body: Padding(
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
                                    "assets/images/Icon.png",
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
  }
}
