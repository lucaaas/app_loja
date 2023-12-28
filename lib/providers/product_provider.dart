import 'package:app_loja/data/dummy_data.dart';
import 'package:app_loja/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts => _products.where((element) => element.isFavorite).toList();

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
