import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;

  const ProductItem({
    required this.product,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
                  product: widget.product,
                )));
      },
      child: GridTile(
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
            mainAxisSize: MainAxisSize.max,
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
                _getProductName(widget.product.name),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        context
                                .read<CartProductsProvider>()
                                .isAddedProduct(widget.product)
                            ? 'Added item to cart'
                            : 'Item removed from cart',
                        textAlign: TextAlign.left,
                      ),
                      duration: const Duration(seconds: 1),
                      action: SnackBarAction(
                        textColor: Colors.red,
                        label: 'cancel',
                        onPressed: () {
                          context
                              .read<CartProductsProvider>()
                              .toggleProduct(widget.product);
                        },
                      ),
                    ),
                  );
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
      ),
    );
  }

  String _getProductName(String name) {
    if (name.length < 6) {
      return name;
    }

    return '${widget.product.name.substring(0, 6)} ...';
  }
}
