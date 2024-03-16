import 'package:app_loja/components/cart_item.dart';
import 'package:app_loja/models/cart_item.dart';
import 'package:app_loja/providers/cart_provider.dart';
import 'package:app_loja/providers/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    final List<CartItem> cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      label: Text(
                        'R\$ ${cart.totalAmount}',
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    const Spacer(),
                    CartButton(cart: cart),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) => CartItemWidget(cartItem: cartItems[index]),
            ),
          )
        ],
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: widget.cart.itemsCount == 0
                ? null
                : () async {
                    setState(() => _isLoading = true);

                    await Provider.of<OrderList>(context, listen: false).addOrder(widget.cart);
                    widget.cart.clear();

                    setState(() => _isLoading = false);
                  },
            style: TextButton.styleFrom(textStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
            child: const Text('Comprar'),
          );
  }
}
