class CartItem {
  final String id;
  final String productId;
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  CartItem.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        productId = data['productId'],
        name = data['name'],
        price = data['price'],
        quantity = data['quantity'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
