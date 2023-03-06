class ProductModel {
  String? id;
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  bool isFavorite = false;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.isFavorite,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    int? price,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
