import 'package:app_loja/components/product_item.dart';
import 'package:app_loja/data/dummy_data.dart';
import 'package:app_loja/models/product.dart';
import 'package:flutter/material.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> products = dummyProducts;

  ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) => ProductItem(product: products[index]),
      ),
    );
  }
}
