import 'package:shop_app/models/models.dart';
import 'package:shop_app/providers/products/products.dart';
import 'package:state_notifier/state_notifier.dart';

import 'cart_products_state.dart';

class CartProductsProvider extends StateNotifier<CartProductsState>
    with LocatorMixin {
  CartProductsProvider() : super(CartProductsState.initial());

  void toggleProduct(Product targetProduct) {
    bool isContained = state.products.contains(targetProduct);
    if (isContained) {
      List<Product> products = state.products
          .where((product) => product.id != targetProduct.id)
          .toList();
      state = CartProductsState(products: [...products]);
      return;
    }

    List<Product> products = [...state.products, targetProduct];
    state = CartProductsState(products: [...products]);
  }

  void clear() {
    state = const CartProductsState(products: []);
  }

  bool isAddedProduct(Product targetProduct) {
    return state.products.contains(targetProduct);
  }

  @override
  void update(Locator watch) {
    ProductsState productsState = watch<ProductsState>();
    List<Product> favoriteProducts =
        productsState.products.where((product) => product.isFavorite).toList();
    state = CartProductsState(products: [...favoriteProducts]);
    super.update(watch);
  }
}
