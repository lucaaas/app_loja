import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Product.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        description = data['description'],
        price = data['price'],
        imageUrl = data['imageUrl'],
        isFavorite = data['isFavorite'];

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite
    };
  }

  @override
  String toString() {
    return name;
  }
}
