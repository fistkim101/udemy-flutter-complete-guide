import 'package:equatable/equatable.dart';

import '../../enums/enums.dart';

class FilterState extends Equatable {
  final Filter filter;

  const FilterState({
    required this.filter,
  });

  @override
  List<Object> get props => [filter];

  factory FilterState.initial() {
    return const FilterState(filter: Filter.all);
  }

  FilterState copyWith({
    Filter? filter,
  }) {
    return FilterState(
      filter: filter ?? this.filter,
    );
  }
}
