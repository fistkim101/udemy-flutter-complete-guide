import 'package:equatable/equatable.dart';

import '../../models/models.dart';

class OrderState extends Equatable {
  final List<Order> orders;

  const OrderState({
    required this.orders,
  });

  factory OrderState.initial() {
    return const OrderState(orders: []);
  }

  @override
  List<Object> get props => [orders];

  OrderState copyWith({
    List<Order>? orders,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
    );
  }
}
