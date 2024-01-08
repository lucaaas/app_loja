import 'package:app_loja/components/app_drawer.dart';
import 'package:app_loja/components/product_item.dart';
import 'package:app_loja/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productProvider.itemsCount,
          itemBuilder: (context, index) => Column(
            children: [
              ProductItem(product: productProvider.products[index]),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
