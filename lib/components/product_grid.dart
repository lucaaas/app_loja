import 'package:app_loja/components/product_item.dart';
import 'package:app_loja/models/product.dart';
import 'package:app_loja/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid({super.key, required this.showFavoriteOnly});

  @override
  Widget build(BuildContext context) {
    final ProductProvider provider = Provider.of<ProductProvider>(context);
    final List<Product> products = showFavoriteOnly ? provider.favoriteProducts : provider.products;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) => ChangeNotifierProvider.value(
        value: products[index],
        child: const ProductItem(),
      ),
    );
  }
}
