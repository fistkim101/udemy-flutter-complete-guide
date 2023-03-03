import 'models.dart';

class OrderModel {
  final List<ProductModel> products;
  final DateTime createdAt;

  const OrderModel({
    required this.products,
    required this.createdAt,
  });

  int getSum() {
    int sum = 0;
    for (var product in products) {
      sum += product.price;
    }
    return sum;
  }
}
