import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class ProductEditListScreen extends StatefulWidget {
  static String routeName = '/product-edit-list';

  const ProductEditListScreen({Key? key}) : super(key: key);

  @override
  State<ProductEditListScreen> createState() => _ProductEditListScreenState();
}

class _ProductEditListScreenState extends State<ProductEditListScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductsState productsState = context.watch<ProductsState>();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.bottomLeft,
          child: const Text('Edit product'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: productsState.products.length,
              itemBuilder: (BuildContext context, int index) {
                final ProductModel product = productsState.products[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.network(product.imageUrl),
                    ),
                    title: Text(product.name),
                    subtitle: Text('\$ ${product.price.toString()}'),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
