import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import '../../models/models.dart';
import 'place_list_state.dart';

class PlaceListProvider extends StateNotifier<PlaceListState> {
  PlaceListProvider() : super(PlaceListState.initial());

  void addPlace(PlaceModel newPlace) {
    state = state.copyWith(places: [...state.places, newPlace]);
  }
}
