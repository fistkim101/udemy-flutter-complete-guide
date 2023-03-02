import 'package:shop_app/models/models.dart';
import 'package:shop_app/providers/products/products.dart';
import 'package:state_notifier/state_notifier.dart';

import 'cart_products_state.dart';

class CartProductsStateProvider extends StateNotifier<CartProductsState>
    with LocatorMixin {
  CartProductsStateProvider() : super(CartProductsState.initial());

  void addToCart(Product product) {
    state = CartProductsState(products: [...state.products, product]);
  }

  void removeFromCart(Product removeTargetProduct) {
    List<Product> targetRemovedProducts = (state.products)
        .where((product) => product.id != removeTargetProduct.id)
        .toList();
    state = CartProductsState(products: targetRemovedProducts);
  }

  void clear() {
    state = const CartProductsState(products: []);
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
