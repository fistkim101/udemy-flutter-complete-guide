import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import 'screens/screens.dart';
import 'service/service.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => ProductService(
            httpClient: http.Client(),
          ),
        ),
        StateNotifierProvider<FilterProvider, FilterState>(
          create: (_) => FilterProvider(),
        ),
        StateNotifierProvider<ProductProvider, ProductState>(
          create: (_) => ProductProvider(),
        ),
        StateNotifierProvider<ProductsProvider, ProductsState>(
          create: (_) => ProductsProvider(),
        ),
        StateNotifierProvider<CartProductsProvider, CartProductsState>(
          create: (_) => CartProductsProvider(),
        ),
        StateNotifierProvider<OrderProvider, OrderState>(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
        ),
        // home: ProductsScreen(),
        routes: {
          ProductsScreen.routeName: (context) => ProductsScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          ProductEditListScreen.routeName: (context) =>
              const ProductEditListScreen(),
          ProductAddEditScreen.routeName: (context) =>
              const ProductAddEditScreen(),
        },
      ),
    );
  }
}
