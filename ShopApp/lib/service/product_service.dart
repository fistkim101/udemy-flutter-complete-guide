import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class ProductService {
  final http.Client httpClient;

  const ProductService({
    required this.httpClient,
  });

  final String url =
      'https://auth-provider-47cd6-default-rtdb.asia-southeast1.firebasedatabase.app/products';

  Future<List<ProductModel>> getProducts() async {
    final http.Response response = await httpClient.get(Uri.parse('$url.json'));
    final Map<String, dynamic> productsJson = jsonDecode(response.body);

    List<ProductModel> products = [];
    productsJson.forEach((productId, data) {
      ProductModel product = ProductModel(
        id: productId,
        name: data['name'],
        description: data['description'],
        imageUrl: data['imageUrl'],
        price: data['price'],
        isFavorite: data['isFavorite'],
      );
      products.add(product);
    });

    return products;
  }

  Future<void> addProduct(ProductModel newProduct) async {
    // TODO try~catch
    try {
      final http.Response response = await httpClient.post(
        Uri.parse('$url.json'),
        body: json.encode({
          'name': newProduct.name,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
          'isFavorite': false,
        }),
      );
    } catch (e) {}
  }

  Future<void> updateProduct(ProductModel product) async {
    // TODO try~catch
    try {
      final http.Response response = await httpClient.patch(
        Uri.parse('$url/${product.id}.json'),
        body: json.encode({
          'name': product.name,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
    } catch (e) {}
  }

  Future<void> deleteProduct(String productId) async {
    // TODO try~catch
    try {
      final http.Response response =
          await httpClient.delete(Uri.parse('$url/$productId.json'));
    } catch (e) {}
  }
}
