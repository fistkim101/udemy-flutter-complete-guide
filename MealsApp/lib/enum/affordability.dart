enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

extension AffordabilityExtension on Affordability {
  String get toText {
    return this.toString().split('.')[1];
  }
}
