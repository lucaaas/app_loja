import 'dart:math';

import 'package:app_loja/models/cart_item.dart';
import 'package:app_loja/models/product.dart';
import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemsCount => _items.length;

  double get totalAmount {
    double total = 0;

    _items.forEach((String key, CartItem cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (CartItem cartItem) => CartItem(
          id: cartItem.id,
          productId: cartItem.productId,
          name: cartItem.name,
          quantity: cartItem.quantity + 1,
          price: cartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }

    notifyListeners();
  }
}
