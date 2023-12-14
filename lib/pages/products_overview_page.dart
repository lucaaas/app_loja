import 'package:app_loja/components/product_grid.dart';
import 'package:flutter/material.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const ProductGrid(),
    );
  }
}
