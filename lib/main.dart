import 'package:app_loja/pages/cart_page.dart';
import 'package:app_loja/pages/orders_page.dart';
import 'package:app_loja/pages/product_detail_page.dart';
import 'package:app_loja/pages/products_overview_page.dart';
import 'package:app_loja/pages/products_page.dart';
import 'package:app_loja/providers/cart_provider.dart';
import 'package:app_loja/providers/order_list.dart';
import 'package:app_loja/providers/product_provider.dart';
import 'package:app_loja/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.HOME: (context) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
          AppRoutes.CART: (context) => const CartPage(),
          AppRoutes.ORDER: (context) => const OrdersPage(),
          AppRoutes.PRODUCTS: (context) => const ProductsPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
