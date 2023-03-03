import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';

class DrawerCustom extends StatelessWidget {
  final double appBarHeight;

  const DrawerCustom(this.appBarHeight, {super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final drawerTopHeight = mediaQuery.padding.top + appBarHeight;

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.green,
            height: drawerTopHeight,
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('shopping list'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text('order'),
            onTap: () {
              Navigator.popAndPushNamed(context, OrdersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
