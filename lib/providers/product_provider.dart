import 'dart:convert';
import 'dart:math';

import 'package:app_loja/exceptions/http_exception.dart';
import 'package:app_loja/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];
  final String _baseUrl = 'https://shop-coder-3d790-default-rtdb.firebaseio.com';

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts => _products.where((element) => element.isFavorite).toList();

  int get itemsCount => _products.length;

  Future<void> loadProducts() async {
    _products.clear();

    final response = await http.get(Uri.parse('$_baseUrl/products.json'));
    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      productData['id'] = productId;
      _products.add(Product.fromJson(productData));
    });

    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) async {
    final String? id = data['id']?.toString();

    final Product product = Product(
      id: id ?? Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (id != null) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    http.Response response = await http.post(Uri.parse('$_baseUrl/products.json'), body: jsonEncode(product.toJson()));
    Map<String, dynamic> body = jsonDecode(response.body);

    // server returns id with key 'name'
    _products.add(
      Product(
          id: body['name'].toString(),
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl),
    );

    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    await http.patch(
      Uri.parse('$_baseUrl/products/${product.id}.json'),
      body: jsonEncode(product.toJson()),
    );

    int index = _products.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(Product product) async {
    int index = _products.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      final product = _products[index];

      _products.remove(product);
      notifyListeners();

      final response = await http.delete(Uri.parse('$_baseUrl/products/${product.id}.jso'));
      if (response.statusCode >= 400) {
        _products.insert(index, product);
        notifyListeners();

        throw HttpException(message: 'Não foi possível excluir o produto.', statusCode: response.statusCode);
      }
    }
  }
}
