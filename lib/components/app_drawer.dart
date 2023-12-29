import 'package:app_loja/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem vindo!'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.ORDER),
          ),
        ],
      ),
    );
  }
}
