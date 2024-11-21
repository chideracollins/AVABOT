import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';

import '../models/gemini_response.dart';
import '../models/product.dart';
import '../models/user_question.dart';

class AvabotBackend {
  const AvabotBackend._();

  static User? get user => FirebaseAuth.instance.currentUser;

  static GeminiResponse _createResponse(Response response) {
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    List<Map> decodedProducts = decodedResponse["products"];
    List<Product>? products;

    if (decodedProducts.isNotEmpty) {
      for (Map product in decodedProducts) {
        products == null
            ? products = [
                Product(
                  id: product["id"],
                  title: product["title"],
                  description: product["description"],
                  price: product["price"],
                  discountPrice: product["discountPercentage"],
                  image: product["thumbnail"],
                )
              ]
            : products.add(Product(
                id: product["id"],
                title: product["title"],
                description: product["description"],
                price: product["price"],
                discountPrice: product["discountPercentage"],
                image: product["thumbnail"],
              ));
      }
    }

    return GeminiResponse(
        response: decodedResponse["response"], products: products);
  }

  static Future<GeminiResponse> reply(UserQuestion question) async {
    String endpoint = "";
    GeminiResponse aiResponse;
    Uri url = Uri.https(endpoint);
    RetryClient client = RetryClient(Client());

    try {
      Map body = {"id": user?.uid};

      if (question.question != null) {
        body["text"] = question.question;
      }

      if (question.attachedImage != null) {
        body["image"] = question.attachedImage;
      }

      Response response = await client.post(url, body: body);

      if (response.statusCode == 201) {
        aiResponse = _createResponse(response);
      } else {
        throw Exception();
      }
    } catch (e) {
      aiResponse = GeminiResponse(
          response:
              "We are having trouble communicating with server currently. Try again later.");
    } finally {
      client.close();
    }
    return aiResponse;
  }
}
