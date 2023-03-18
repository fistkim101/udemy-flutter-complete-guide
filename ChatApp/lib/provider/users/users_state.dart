import 'package:equatable/equatable.dart';

import '../../enum/enum.dart';
import '../../model/model.dart';

class UsersState extends Equatable {
  final List<UserModel> addTargetUsers;
  final ProgressType progressType;

  const UsersState({
    required this.addTargetUsers,
    required this.progressType,
  });

  @override
  List<Object> get props => [addTargetUsers, progressType];

  factory UsersState.initial() {
    return const UsersState(
      addTargetUsers: [],
      progressType: ProgressType.initial,
    );
  }

  UsersState copyWith({
    List<UserModel>? addTargetUsers,
    ProgressType? progressType,
  }) {
    return UsersState(
      addTargetUsers: addTargetUsers ?? this.addTargetUsers,
      progressType: progressType ?? this.progressType,
    );
  }
}
