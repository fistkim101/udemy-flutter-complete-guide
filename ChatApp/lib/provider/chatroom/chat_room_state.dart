import 'package:equatable/equatable.dart';

import '../../enum/enum.dart';
import '../../model/model.dart';

class ChatRoomState extends Equatable {
  final List<UserModel> counterPartUsers;
  final ProgressType progressType;

  const ChatRoomState({
    required this.counterPartUsers,
    required this.progressType,
  });

  factory ChatRoomState.initial() {
    return const ChatRoomState(
      counterPartUsers: [],
      progressType: ProgressType.initial,
    );
  }

  @override
  List<Object> get props => [counterPartUsers, progressType];

  ChatRoomState copyWith({
    List<UserModel>? counterPartUsers,
    ProgressType? progressType,
  }) {
    return ChatRoomState(
      counterPartUsers: counterPartUsers ?? this.counterPartUsers,
      progressType: progressType ?? this.progressType,
    );
  }
}
