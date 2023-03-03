import 'models.dart';

class Order {
  final List<Product> products;
  final DateTime createdAt;

  const Order({
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
