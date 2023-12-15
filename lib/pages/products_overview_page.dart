import 'package:app_loja/components/product_grid.dart';
import 'package:flutter/material.dart';

enum FilterOptions { FAVORITE, ALL }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_alt),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: FilterOptions.FAVORITE,
                child: Text('Somente favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.ALL,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions value) {
              setState(() {
                showFavoriteOnly = (value == FilterOptions.FAVORITE);
              });
            },
          )
        ],
      ),
      body: ProductGrid(showFavoriteOnly: showFavoriteOnly),
    );
  }
}
