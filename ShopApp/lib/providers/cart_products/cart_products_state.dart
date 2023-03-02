import 'package:equatable/equatable.dart';

import '../../models/models.dart';

class CartProductsState extends Equatable {
  final List<Product> products;

  const CartProductsState({
    required this.products,
  });

  @override
  List<Object> get props => [products];

  factory CartProductsState.initial() {
    return const CartProductsState(products: []);
  }

  CartProductsState copyWith({
    List<Product>? products,
  }) {
    return CartProductsState(
      products: products ?? this.products,
    );
  }
}
