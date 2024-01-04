import 'package:app_loja/components/app_drawer.dart';
import 'package:app_loja/components/order_widget.dart';
import 'package:app_loja/providers/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderList.itemsCount,
        itemBuilder: (context, index) => OrderWidget(order: orderList.items[index]),
      ),
    );
  }
}
