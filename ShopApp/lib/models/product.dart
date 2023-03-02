class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  bool isFavorite = false;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });
}
