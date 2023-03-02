import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:shop_app/models/models.dart';

import 'cart_products_state.dart';

class CartProductsStateProvider extends StateNotifier<CartProductsState> {
  CartProductsStateProvider() : super(CartProductsState.initial());

  void addProduct(Product product) {
    state = CartProductsState(products: [...state.products, product]);
  }

  void removeProduct(Product removeTargetProduct) {
    List<Product> targetRemovedProducts = (state.products)
        .where((product) => product.id != removeTargetProduct.id)
        .toList();
    state = CartProductsState(products: targetRemovedProducts);
  }

  void clear() {
    state = const CartProductsState(products: []);
  }
}
