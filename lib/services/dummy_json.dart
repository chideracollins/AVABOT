import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/retry.dart';

import '../models/product.dart';

class DummyJson {
  DummyJson._();

  static const String _apiUrl = "dummyjson.com";

  static Future<Response?> _request(Client client, String endpoint) async {
    Uri url = Uri.https(_apiUrl, endpoint);
    var response = await client.get(url);
    return response.statusCode == 200 ? response : null;
  }

  static Future<String?> search(List<String> data) async {
    String? results;
    RetryClient client = RetryClient(Client());

    try {
      for (String endpoint in data) {
        Response? response = await _request(client, endpoint);
        if (response == null) continue;
        results ??= "";
        results += "${data.indexOf(endpoint)}) $response";
      }
    } finally {
      client.close();
    }
    return results;
  }

  static Product _createProduct(Map productDetails) {
    return Product(
      id: productDetails["id"],
      title: productDetails["title"],
      price: productDetails["price"],
      discountPrice: productDetails["discountPercentage"],
      image: productDetails["thumbnail"],
    );
  }

  static Future<List<Product>?> getProducts(List<String>? data) async {
    print("DummyJson is being called, with this values: $data");
    if (data == null) return null;
    List<Product> products = [];
    RetryClient client = RetryClient(Client());
    try {
      for (String id in data) {
        String endpoint = "/products/$id";
        Response? response = await _request(client, endpoint);
        if (response == null) continue;
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        products.add(_createProduct(decodedResponse));
      }
    } finally {
      client.close();
    }
    return products;
  }
}
