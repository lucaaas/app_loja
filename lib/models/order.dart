import 'package:app_loja/models/cart_item.dart';

class Order {
  String? id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({this.id, required this.total, required this.products, required this.date});

  Order.fromJson(Map<String, dynamic> orderData)
      : id = orderData['id'],
        total = orderData['total'],
        date = DateTime.parse(orderData['date']),
        products = List<CartItem>.from(orderData['products'].map((data) => CartItem.fromJson(data)).toList());

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'date': date.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
