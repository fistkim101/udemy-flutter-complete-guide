import 'package:equatable/equatable.dart';

import '../../models/models.dart';

class PlaceListState extends Equatable {
  final List<PlaceModel> places;

  const PlaceListState({
    required this.places,
  });

  factory PlaceListState.initial() {
    return const PlaceListState(places: []);
  }

  @override
  List<Object> get props => [places];

  PlaceListState copyWith({
    List<PlaceModel>? places,
  }) {
    return PlaceListState(
      places: places ?? this.places,
    );
  }
}
