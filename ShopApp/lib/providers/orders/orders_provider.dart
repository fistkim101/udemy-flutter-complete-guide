import 'package:state_notifier/state_notifier.dart';

import '../../models/models.dart';
import 'orders_state.dart';

class OrderProvider extends StateNotifier<OrderState> {
  OrderProvider() : super(OrderState.initial());

  void addOrder(List<Product> products) {
    final Order newOrder = Order(products: products, createdAt: DateTime.now());
    state = OrderState(orders: [...state.orders, newOrder]);
  }
}
