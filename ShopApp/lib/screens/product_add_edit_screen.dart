import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_edit_list_screen.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class ProductAddEditScreen extends StatefulWidget {
  static String routeName = '/product-add-edit';

  final ProductModel? product;

  const ProductAddEditScreen({
    this.product,
  });

  @override
  State<ProductAddEditScreen> createState() => _ProductAddEditScreenState();
}

class _ProductAddEditScreenState extends State<ProductAddEditScreen> {
  final _formState = GlobalKey<FormState>();
  late String _productName;
  late String _productDescription;
  late String _productImageUrl;
  late int _productPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomLeft,
          child: widget.product != null
              ? Text('Edit ${widget.product!.name}')
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
                    initialValue:
                        widget.product != null ? widget.product!.name : '',
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
                    initialValue: widget.product != null
                        ? widget.product!.description
                        : '',
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
                    initialValue: widget.product != null
                        ? widget.product!.price.toString()
                        : '0',
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
                final ProductModel product = ProductModel(
                  id: _getProductId(context),
                  name: _productName,
                  description: _productDescription,
                  imageUrl: _getProductImageUrl(),
                  price: _productPrice,
                );

                if (widget.product == null) {
                  context.read<ProductsProvider>().addProduct(product);
                } else {
                  context.read<ProductsProvider>().editProduct(product);
                }

                Navigator.pop(context);
                // Navigator.pushReplacementNamed(context, ProductEditListScreen.routeName);
              },
              child: Text('submit'),
            )
          ],
        ),
      ),
    );
  }

  String _getProductId(BuildContext context) {
    if (widget.product == null) {
      int newProductId = context.read<ProductsProvider>().getNextProductId();
      return newProductId.toString();
    }

    return widget.product!.id.toString();
  }

  String _getProductName() {
    if (widget.product == null) {
      return _productName;
    }

    return widget.product!.name;
  }

  String _getProductDescription() {
    if (widget.product == null) {
      return _productDescription;
    }

    return widget.product!.description;
  }

  String _getProductImageUrl() {
    if (widget.product == null) {
      return 'https://picsum.photos/200';
    }

    return widget.product!.imageUrl;
  }

  int _getProductPrice() {
    if (widget.product == null) {
      return _productPrice;
    }

    return widget.product!.price;
  }
}
