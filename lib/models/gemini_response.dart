import 'product.dart';

class GeminiResponse {
  final String response;
  final List<Product>? products;
  late bool success = true;

  GeminiResponse({required this.response, this.products});
}
