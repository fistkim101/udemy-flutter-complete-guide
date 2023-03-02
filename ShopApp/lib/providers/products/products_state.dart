import 'package:equatable/equatable.dart';

import '../../models/models.dart';

class ProductsState extends Equatable {
  final List<Product> products;

  const ProductsState({
    required this.products,
  });

  factory ProductsState.initial() {
    return const ProductsState(products: []);
  }

  @override
  List<Object> get props => [products];

  ProductsState copyWith({
    List<Product>? products,
  }) {
    return ProductsState(
      products: products ?? this.products,
    );
  }
}
