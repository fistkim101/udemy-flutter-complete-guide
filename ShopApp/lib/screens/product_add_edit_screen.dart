import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductAddEditScreen extends StatefulWidget {
  static String routeName = '/product-add-edit';

  const ProductAddEditScreen({super.key});

  @override
  State<ProductAddEditScreen> createState() => _ProductAddEditScreenState();
}

class _ProductAddEditScreenState extends State<ProductAddEditScreen> {
  final Key _formState = GlobalKey<FormState>();
  late String _productName;
  late String _productDescription;
  late String _productImageUrl;
  late int _price;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formState,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter product name',
              labelText: 'Name',
              // prefixIcon: Icon(Icons.email),
              // suffixIcon: Icon(Icons.email),
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
        ],
      ),
    );
  }
}
