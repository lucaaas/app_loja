import 'dart:math';

import 'package:app_loja/data/dummy_data.dart';
import 'package:app_loja/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts => _products.where((element) => element.isFavorite).toList();

  int get itemsCount => _products.length;

  void saveProduct(Map<String, Object> data) {
    final String? id = data['id']?.toString();

    final Product product = Product(
      id: id ?? Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (id != null) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
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
