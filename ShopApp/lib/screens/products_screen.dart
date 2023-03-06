import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/enums.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';

class ProductsScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductsState productsState = context.watch<ProductsState>();
    final Filter currentFilter = context.watch<FilterState>().filter;

    final AppBar appBar = AppBar(
      title: Container(
        alignment: Alignment.bottomLeft,
        child: const Text(
          'ShopApp',
          textAlign: TextAlign.start,
        ),
      ),
      actions: [
        _buildFilterButton(context),
        _buildCartActionButton(context),
      ],
    );

    return Scaffold(
      drawer: DrawerCustom(appBar.preferredSize.height),
      appBar: appBar,
      body: productsState.processStatusType == ProcessStatusType.processing
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: productsState.products
                    .where((product) => _filterProduct(product, currentFilter))
                    .map((product) => ProductItem(product: product))
                    .toList(),
              ),
            ),
    );
  }

  Widget _buildCartActionButton(BuildContext context) {
    final int cartProductsCount =
        context.watch<CartProductsState>().products.length;

    return Stack(
      children: [
        SizedBox(
          height: 56,
          width: 48,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            child: const Icon(
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

  Widget _buildFilterButton(BuildContext context) {
    return PopupMenuButton(
      onSelected: (Filter filter) {
        context.read<FilterProvider>().changeFilter(filter);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Filter>>[
        const PopupMenuItem<Filter>(
          value: Filter.all,
          child: Text('all'),
        ),
        const PopupMenuItem<Filter>(
          value: Filter.favorite,
          child: Text('favorite'),
        ),
      ],
      child: const SizedBox(
        height: 56,
        width: 48,
        child: Icon(
          Icons.filter_alt_outlined,
        ),
      ),
    );
  }

  bool _filterProduct(ProductModel product, Filter filter) {
    if (filter == Filter.all) {
      return true;
    }

    return product.isFavorite;
  }
}
