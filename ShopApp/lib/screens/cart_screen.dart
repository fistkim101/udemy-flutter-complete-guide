import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Text('Cart'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildTotalSum(context),
            SizedBox(
              height: 10,
            ),
            _buildProductList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleProduct(BuildContext context, Product product) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          height: 50,
          width: 50,
          child: Image.network(product.imageUrl),
        ),
        title: Text(product.name),
        subtitle: Text('\$ ${product.price}'),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              context.read<CartProductsProvider>().toggleProduct(product);
            });
          },
          child: Icon(Icons.delete),
        ),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    final CartProductsState cartProductsState =
        context.watch<CartProductsState>();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cartProductsState.products.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildSingleProduct(context, cartProductsState.products[index]));
  }

  Widget _buildTotalSum(BuildContext context) {
    final CartProductsState cartProductsState =
        context.watch<CartProductsState>();
    int priceSum = 0;
    for (var product in cartProductsState.products) {
      priceSum += product.price;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Total : $priceSum',
          style: TextStyle(fontSize: 20),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                context.read<CartProductsProvider>().clear();
                context
                    .read<OrderProvider>()
                    .addOrder(cartProductsState.products);
              },
              child: Text('order now !!!'),
            ),
          ),
        )
      ],
    );
  }
}
