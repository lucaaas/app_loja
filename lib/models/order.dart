import 'package:app_loja/models/cart_item.dart';

class Order {
  String? id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({this.id, required this.total, required this.products, required this.date});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'date': date.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
