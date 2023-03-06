import 'package:equatable/equatable.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';

class ProductsState extends Equatable {
  final List<ProductModel> products;
  final ProcessStatusType processStatusType;

  const ProductsState({
    required this.products,
    required this.processStatusType,
  });

  factory ProductsState.initial() {
    return const ProductsState(
      products: [],
      processStatusType: ProcessStatusType.initial,
    );
  }

  @override
  List<Object> get props => [products, processStatusType];

  ProductsState copyWith({
    List<ProductModel>? products,
    ProcessStatusType? processStatusType,
  }) {
    return ProductsState(
      products: products ?? this.products,
      processStatusType: processStatusType ?? this.processStatusType,
    );
  }
}
