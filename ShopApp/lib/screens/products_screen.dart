import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class ProductsScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Widget _buildCartActionButton(BuildContext context) {
    final int cartProductsCount =
        context.watch<CartProductsState>().products.length;

    return Stack(
      children: [
        SizedBox(
          height: 56,
          width: 48,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ),
        cartProductsCount != 0
            ? Positioned(
                top: 8,
                left: 29,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  height: 14,
                  width: 14,
                  child: Text(
                    '$cartProductsCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Container(
        alignment: Alignment.bottomLeft,
        child: const Text(
          'ShopApp',
          textAlign: TextAlign.start,
        ),
      ),
      actions: [
        SizedBox(
          height: 56,
          width: 48,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_alt_outlined,
            ),
          ),
        ),
        _buildCartActionButton(context),
      ],
    );

    return Scaffold(
      drawer: DrawerCustom(appBar.preferredSize.height),
      appBar: appBar,
    );
  }
}
