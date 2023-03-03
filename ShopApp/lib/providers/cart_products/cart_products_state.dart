import 'package:equatable/equatable.dart';

import '../../models/models.dart';

class CartProductsState extends Equatable {
  final List<ProductModel> products;

  const CartProductsState({
    required this.products,
  });

  @override
  List<Object> get props => [products];

  factory CartProductsState.initial() {
    return const CartProductsState(products: []);
  }

  CartProductsState copyWith({
    List<ProductModel>? products,
  }) {
    return CartProductsState(
      products: products ?? this.products,
    );
  }
}
