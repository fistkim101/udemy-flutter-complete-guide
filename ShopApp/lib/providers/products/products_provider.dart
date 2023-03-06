import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:shop_app/service/product_service.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';
import 'products_state.dart';

class ProductsProvider extends StateNotifier<ProductsState> with LocatorMixin {
  ProductsProvider() : super(ProductsState.initial());

  void fetchProducts() async {
    state = state.copyWith(processStatusType: ProcessStatusType.processing);

    List<ProductModel> products = await read<ProductService>().getProducts();

    state = ProductsState(
        products: products, processStatusType: ProcessStatusType.success);
  }

  void toggleFavorite(ProductModel targetProduct) async {
    // state = state.copyWith(processStatusType: ProcessStatusType.processing);

    targetProduct.isFavorite = !targetProduct.isFavorite;
    await read<ProductService>().updateProduct(targetProduct);
    List<ProductModel> products = await read<ProductService>().getProducts();

    state = ProductsState(
        products: products, processStatusType: ProcessStatusType.success);
  }

  void deleteProduct(ProductModel targetProduct) async {
    state = state.copyWith(processStatusType: ProcessStatusType.processing);

    await read<ProductService>().deleteProduct(targetProduct.id!);
    List<ProductModel> products = await read<ProductService>().getProducts();

    state = ProductsState(
        products: products, processStatusType: ProcessStatusType.success);
  }
}
