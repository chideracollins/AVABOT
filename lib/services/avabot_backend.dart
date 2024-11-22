import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../models/gemini_response.dart';
import '../models/product.dart';
import '../models/user_question.dart';

class AvabotBackend {
  const AvabotBackend._();

  static User? get user => FirebaseAuth.instance.currentUser;

  static GeminiResponse _createResponse(String response) {
    var decodedResponse = jsonDecode(response) as Map;
    print(decodedResponse);

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

    return GeminiResponse(
        response: decodedResponse["response"], products: products);
  }

  static Future<GeminiResponse> reply(UserQuestion question) async {
    String endpoint = "avabot-backend-agent.onrender.com";
    GeminiResponse aiResponse;
    Uri url = Uri.https(endpoint, "/chat");
    final request = http.MultipartRequest('POST', url);

    if (question.question != null) {
      request.fields['text'] = question.question!;
    }

    if (question.attachedImage != null) {
      String? path = question.attachedImage?.path;
      if (path != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          path,
        ));
      }
    }

    if (user?.uid != null) {
      String? userId = user?.uid;
      request.fields['id'] = userId!;
    }

    try {
      int retries = 0;
      int maxRetries = 50;
      bool apiSuccess = false;
      http.StreamedResponse? response;
      print("Trying to send request");

      while (retries < maxRetries && !apiSuccess) {
        try {
          response = await request.send();
          apiSuccess = true;
        } finally {
          retries += 1;
        }
      }

      if (!apiSuccess) {
        throw Exception();
      }

      print("Sent request");

      if (response?.statusCode == 201) {
        final responseBody = await response?.stream.bytesToString();
        aiResponse = _createResponse(responseBody!);
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
      aiResponse = GeminiResponse(
        response:
            "We are having trouble communicating with server currently. Try again later.",
        products: [
          Product(
            id: 3,
            title: "Powder Canister",
            description:
                "The Powder Canister is a finely milled setting powder designed to set makeup and control shine. With a lightweight and translucent formula, it provides a smooth and matte finish.",
            dollarPrice: 14.99,
            dollarDiscountPrice: 18.14,
            image:
                "https://cdn.dummyjson.com/products/images/beauty/Powder%20Canister/thumbnail.png",
          ),
          Product(
            id: 3,
            title: "Powder Canister",
            description:
                "The Powder Canister is a finely milled setting powder designed to set makeup and control shine. With a lightweight and translucent formula, it provides a smooth and matte finish.",
            dollarPrice: 14.99,
            dollarDiscountPrice: 18.14,
            image:
                "https://cdn.dummyjson.com/products/images/beauty/Powder%20Canister/thumbnail.png",
          ),
          Product(
            id: 3,
            title: "Powder Canister",
            description:
                "The Powder Canister is a finely milled setting powder designed to set makeup and control shine. With a lightweight and translucent formula, it provides a smooth and matte finish.",
            dollarPrice: 14.99,
            dollarDiscountPrice: 18.14,
            image:
                "https://cdn.dummyjson.com/products/images/beauty/Powder%20Canister/thumbnail.png",
          ),
          Product(
            id: 3,
            title: "Powder Canister",
            description:
                "The Powder Canister is a finely milled setting powder designed to set makeup and control shine. With a lightweight and translucent formula, it provides a smooth and matte finish.",
            dollarPrice: 14.99,
            dollarDiscountPrice: 18.14,
            image:
                "https://cdn.dummyjson.com/products/images/beauty/Powder%20Canister/thumbnail.png",
          ),
        ],
      );
    }

    return aiResponse;
  }
}
