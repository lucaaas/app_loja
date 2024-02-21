import 'dart:convert';
import 'dart:math';

import 'package:app_loja/data/dummy_data.dart';
import 'package:app_loja/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final List<Product> _products = dummyProducts;
  final String _baseUrl = 'https://shop-coder-3d790-default-rtdb.firebaseio.com';

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts => _products.where((element) => element.isFavorite).toList();

  int get itemsCount => _products.length;

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
    int index = _products.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(Product product) {
    int index = _products.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _products.removeAt(index);
      notifyListeners();
    }
  }
}
