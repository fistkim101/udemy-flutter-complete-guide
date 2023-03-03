import 'package:state_notifier/state_notifier.dart';

import '../../models/models.dart';
import 'orders_state.dart';

class OrderProvider extends StateNotifier<OrderState> {
  OrderProvider() : super(OrderState.initial());

  void addOrder(List<ProductModel> products) {
    final OrderModel newOrder = OrderModel(products: products, createdAt: DateTime.now());
    state = OrderState(orders: [...state.orders, newOrder]);
  }
}
