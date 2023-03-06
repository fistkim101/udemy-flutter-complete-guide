import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product/product.dart';
import 'package:shop_app/providers/products/products.dart';

import '../models/models.dart';

class ProductAddEditScreen extends StatefulWidget {
  static String routeName = '/product-add-edit';

  const ProductAddEditScreen({super.key});

  @override
  State<ProductAddEditScreen> createState() => _ProductAddEditScreenState();
}

class _ProductAddEditScreenState extends State<ProductAddEditScreen> {
  final _formState = GlobalKey<FormState>();
  late String _productName;
  late String _productDescription;
  late int _productPrice;

  @override
  Widget build(BuildContext context) {
    final ProductModel? product = context.watch<ProductState>().product;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomLeft,
          child: product != null
              ? Text('Edit ${product!.name}')
              : const Text('Add new product'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
              key: _formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    initialValue: product != null ? product.name : '',
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter product name',
                      labelText: 'Name',
                    ),
                    validator: (String? name) {
                      if (name == null || name == '') {
                        return 'Enter name ...';
                      }
                    },
                    onSaved: (String? name) {
                      _productName = name!;
                    },
                  ),
                  TextFormField(
                    initialValue: product != null ? product.description : '',
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter product description',
                      labelText: 'Description',
                    ),
                    validator: (String? description) {
                      if (description == null || description == '') {
                        return 'Enter description ...';
                      }
                    },
                    onSaved: (String? description) {
                      _productDescription = description!;
                    },
                  ),
                  TextFormField(
                    initialValue:
                        product != null ? product.price.toString() : '0',
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter product price',
                      labelText: 'Price',
                    ),
                    validator: (String? price) {
                      if (price == null || price == '') {
                        return 'Enter price ...';
                      }
                    },
                    onSaved: (String? price) {
                      _productPrice = int.parse(price!);
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _formState.currentState!.save();
                final ProductModel targetProduct = _getTargetProduct(product);

                if (product == null) {
                  context.read<ProductProvider>().addProduct(targetProduct);
                } else {
                  context.read<ProductProvider>().editProduct(targetProduct);
                }
                context.read<ProductsProvider>().fetchProducts();
                Navigator.pop(context);
              },
              child: Text('submit'),
            )
          ],
        ),
      ),
    );
  }

  String _getProductImageUrl(ProductModel? product) {
    if (product == null) {
      return 'https://picsum.photos/200';
    }

    return product!.imageUrl;
  }

  _getTargetProduct(ProductModel? product) {
    final String? productId = product?.id;
    final bool isFavorite = product == null ? false : product.isFavorite;

    return ProductModel(
      id: productId,
      name: _productName,
      description: _productDescription,
      imageUrl: _getProductImageUrl(product),
      price: _productPrice,
      isFavorite: isFavorite,
    );
  }
}
