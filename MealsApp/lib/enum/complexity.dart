enum Complexity {
  Simple,
  Challenging,
  Hard,
}

extension ComplexityExtension on Complexity {
  String get toText {
    return this.toString().split('.')[1];
  }
}
