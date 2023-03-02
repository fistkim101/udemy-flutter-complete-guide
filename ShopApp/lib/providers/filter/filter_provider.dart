import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import '../../enums/enums.dart';
import 'filter_state.dart';

class FilterProvider extends StateNotifier<FilterState> {
  FilterProvider() : super(FilterState.initial());

  void changeFilter(Filter selectedFilter) {
    state = state.copyWith(filter: selectedFilter);
  }
}
