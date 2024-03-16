import 'dart:convert';

import 'package:app_loja/models/order.dart';
import 'package:app_loja/providers/cart_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  final String _baseUrl = 'https://shop-coder-3d790-default-rtdb.firebaseio.com';

  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> addOrder(Cart cart) async {
    Order order = Order(
      total: cart.totalAmount,
      products: cart.items.values.toList(),
      date: DateTime.now(),
    );

    http.Response response = await http.post(Uri.parse('$_baseUrl/orders.json'), body: jsonEncode(order.toJson()));
    Map<String, dynamic> body = jsonDecode(response.body);
    order.id = body['name'];

    _items.insert(0, order);
    notifyListeners();
  }
}
