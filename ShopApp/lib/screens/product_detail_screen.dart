import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductDetailScreen extends StatefulWidget {
  static String routeName = '/product-detail';

  final ProductModel product;

  const ProductDetailScreen({
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Text(widget.product.name),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Text(widget.product.name),
            Text('\$ ${widget.product.price.toString()}'),
            Text(widget.product.description),
          ],
        ),
      ),
    );
  }
}
