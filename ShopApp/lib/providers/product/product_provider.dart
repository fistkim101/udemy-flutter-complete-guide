import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';
import '../../service/service.dart';
import 'product_state.dart';

class ProductProvider extends StateNotifier<ProductState> with LocatorMixin {
  ProductProvider() : super(ProductState.initial());

  void selectProduct(ProductModel targetProduct) {
    state = state.copyWith(
        product: targetProduct, processStatusType: ProcessStatusType.success);
  }

  void addProduct(ProductModel newProduct) async {
    state = state.copyWith(
        product: null, processStatusType: ProcessStatusType.processing);

    await read<ProductService>().addProduct(newProduct);

    state = state.copyWith(processStatusType: ProcessStatusType.success);
  }

  void editProduct(ProductModel editTargetProduct) async {
    state = state.copyWith(processStatusType: ProcessStatusType.processing);

    await read<ProductService>().updateProduct(editTargetProduct);

    state = state.copyWith(processStatusType: ProcessStatusType.success);
  }
}
