import 'package:shop_app/models/models.dart';
import 'package:state_notifier/state_notifier.dart';

import 'cart_products_state.dart';

class CartProductsProvider extends StateNotifier<CartProductsState>
    with LocatorMixin {
  CartProductsProvider() : super(CartProductsState.initial());

  void toggleProduct(ProductModel targetProduct) {
    bool isContained = state.products.contains(targetProduct);
    if (isContained) {
      List<ProductModel> products = state.products
          .where((product) => product.id != targetProduct.id)
          .toList();
      state = CartProductsState(products: [...products]);
      return;
    }

    List<ProductModel> products = [...state.products, targetProduct];
    state = CartProductsState(products: [...products]);
  }

  void clear() {
    state = const CartProductsState(products: []);
  }

  bool isAddedProduct(ProductModel targetProduct) {
    return state.products.contains(targetProduct);
  }
}
