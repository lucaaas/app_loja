import 'package:app_loja/components/app_drawer.dart';
import 'package:app_loja/components/order_widget.dart';
import 'package:app_loja/providers/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(context, listen: false).loadOrders().then((value) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: orderList.loadOrders,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: orderList.itemsCount,
                itemBuilder: (context, index) => OrderWidget(order: orderList.items[index]),
              ),
      ),
    );
  }
}
