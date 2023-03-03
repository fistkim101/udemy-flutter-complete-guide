import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({
    required this.product,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        // clipBehavior: Clip.hardEdge,
        child: Image.network(
          widget.product.imageUrl,
        ),
      ),
      footer: Container(
        color: Colors.black38,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  context
                      .read<ProductsProvider>()
                      .toggleFavorite(widget.product);
                });
              },
              icon: Icon(
                widget.product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: Colors.red,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              widget.product.name,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 3,
            ),
            IconButton(
              onPressed: () {
                context
                    .read<CartProductsProvider>()
                    .toggleProduct(widget.product);
              },
              icon: Icon(
                context
                        .watch<CartProductsProvider>()
                        .isAddedProduct(widget.product)
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
