import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../models/gemini_response.dart';
import '../models/product.dart';
import '../models/user_question.dart';

class AvabotBackend {
  const AvabotBackend._();

  static const _endpoint = "avabot-backend-agent.onrender.com";
  static User? get _user => FirebaseAuth.instance.currentUser;

  static (GeminiResponse, Map<String, String>?) _createResponse(
      String response) {
    var decodedResponse = jsonDecode(response) as Map;

    var decodedProducts = decodedResponse["products"];
    List<Product>? products;

    if (decodedProducts != null) {
      for (Map product in decodedProducts) {
        products == null
            ? products = [
                Product(
                  id: product["id"],
                  title: product["title"],
                  description: product["description"],
                  dollarPrice: product["price"],
                  dollarDiscountPrice: product["discountPercentage"],
                  image: product["thumbnail"],
                )
              ]
            : products.add(Product(
                id: product["id"],
                title: product["title"],
                description: product["description"],
                dollarPrice: product["price"],
                dollarDiscountPrice: product["discountPercentage"],
                image: product["thumbnail"],
              ));
      }
    }

    final chatHistory = decodedResponse["chat-history"];
    Map<String, String>? decodedChatHistory;
    if (chatHistory != null) {
      for (var convo in chatHistory.entries) {
        String key = convo.key.toString();
        String value = convo.value.toString();
        decodedChatHistory == null
            ? decodedChatHistory = {key: value}
            : decodedChatHistory[key] = value;
      }
    }


    return (
      GeminiResponse(response: decodedResponse["response"], products: products),
      decodedChatHistory,
    );
  }

  static Future<(GeminiResponse, Map<String, String>?)> reply(
      UserQuestion question, Map<String, String>? serializedHistory) async {
    GeminiResponse aiResponse;
    Uri url = Uri.https(_endpoint, "/chat");

    Map payload = {'id': _user!.uid};

    if (question.question != null) {
      payload['text'] = question.question!;
    }

    if (question.imageUrl != null) {
      payload["image-url"] = question.imageUrl!;
    }

    if (serializedHistory != null) {
      payload["chat-history"] = serializedHistory;
    }
    try {
      int retries = 0;
      int maxRetries = 30;
      bool apiSuccess = false;
      http.Response? response;

      while (retries < maxRetries && !apiSuccess) {
        try {
          response = await http.post(
            url,
            headers: {"Content-Type": "application/json"},
            body: json.encode(payload),
          );
          apiSuccess = true;
        } finally {
          retries += 1;
        }
      }

      if (!apiSuccess) {
        throw Exception();
      }
      if (response?.statusCode == 201) {
        final responseBody = response?.body;
        final (geminiResponse, updatedHistory) = _createResponse(responseBody!);
        aiResponse = geminiResponse;
        serializedHistory = updatedHistory;
      } else {
        throw Exception();
      }
    } catch (e) {
      aiResponse = GeminiResponse(
        response:
            "We are having trouble communicating with server currently. Try again later.",
      );
    }

    return (aiResponse, serializedHistory);
  }
}
