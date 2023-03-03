import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_single.dart';

import '../providers/providers.dart';

class OrdersScreen extends StatefulWidget {
  static String routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final OrderState orderState = context.read<OrderState>();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Text('Orders'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: orderState.orders.length,
              itemBuilder: (BuildContext context, int index) =>
                  OrderSingle(order: orderState.orders[index]),
            ),
          ],
        ),
      ),
    );
  }
}
