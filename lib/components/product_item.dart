import 'package:app_loja/models/product.dart';
import 'package:app_loja/providers/product_provider.dart';
import 'package:app_loja/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM, arguments: product),
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            IconButton(
              onPressed: () async {
                final bool removeItem = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Tem certeza?'),
                    content: const Text('Deseja remover o produto'),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Sim')),
                      TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Não')),
                    ],
                  ),
                );

                if (removeItem) {
                  Provider.of<ProductProvider>(context, listen: false).deleteProduct(product);
                }
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.errorContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
