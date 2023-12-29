import 'package:app_loja/components/app_drawer.dart';
import 'package:app_loja/components/badge.dart';
import 'package:app_loja/components/product_grid.dart';
import 'package:app_loja/providers/cart_provider.dart';
import 'package:app_loja/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.CART),
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (BuildContext context, Cart cart, Widget? child) => BadgeWidget(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductGrid(showFavoriteOnly: showFavoriteOnly),
    );
  }
}
