import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../enums/enums.dart';

class ProductState extends Equatable {
  final ProductModel? product;
  final ProcessStatusType processStatusType;

  const ProductState({
    required this.product,
    required this.processStatusType,
  });

  factory ProductState.initial() {
    return const ProductState(
        product: null, processStatusType: ProcessStatusType.initial);
  }

  @override
  List<Object?> get props => [product, processStatusType];

  ProductState copyWith({
    ProductModel? product,
    ProcessStatusType? processStatusType,
  }) {
    return ProductState(
      product: product ?? this.product,
      processStatusType: processStatusType ?? this.processStatusType,
    );
  }
}
