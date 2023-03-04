import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import '../../models/models.dart';
import 'products_state.dart';

class ProductsProvider extends StateNotifier<ProductsState> {
  ProductsProvider() : super(ProductsState.initial());

  void fetchProducts(List<ProductModel> products) {
    state = ProductsState(products: [...products]);
  }

  void toggleFavorite(ProductModel targetProduct) {
    ProductModel product =
        state.products.firstWhere((product) => product.id == targetProduct.id);
    product.isFavorite = !product.isFavorite;
    state = ProductsState(products: [...state.products]);
  }

  void deleteProduct(ProductModel targetProduct) {
    List<ProductModel> products = state.products
        .where((product) => product.id != targetProduct.id)
        .toList();
    state = ProductsState(products: [...products]);
  }

  int getNextProductId() {
    int newProductId = state.products.length + 1;
    return newProductId;
  }

  void addProduct(ProductModel newProduct) {
    state = ProductsState(products: [...state.products, newProduct]);
  }

  void editProduct(ProductModel editTargetProduct) {
    List<ProductModel> products = state.products
        .where((product) => product.id != editTargetProduct.id)
        .toList();
    state = ProductsState(products: [...products, editTargetProduct]);
  }
}
