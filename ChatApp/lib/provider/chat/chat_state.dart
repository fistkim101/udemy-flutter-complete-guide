import 'package:equatable/equatable.dart';

import '../../enum/enum.dart';
import '../../model/model.dart';

class ChatState extends Equatable {
  final ProgressType progressType;
  final UserModel? counterPartUser;
  final UserModel? currentUser;
  final String? chatRoomUid;

  @override
  List<Object?> get props =>
      [progressType, counterPartUser, currentUser, chatRoomUid];

  factory ChatState.initial() {
    return const ChatState(
      progressType: ProgressType.initial,
      counterPartUser: null,
      currentUser: null,
      chatRoomUid: null,
    );
  }

  const ChatState({
    required this.progressType,
    required this.counterPartUser,
    required this.currentUser,
    required this.chatRoomUid,
  });

  ChatState copyWith({
    ProgressType? progressType,
    UserModel? counterPartUser,
    UserModel? currentUser,
    String? chatRoomUid,
  }) {
    return ChatState(
      progressType: progressType ?? this.progressType,
      counterPartUser: counterPartUser ?? this.counterPartUser,
      currentUser: currentUser ?? this.currentUser,
      chatRoomUid: chatRoomUid ?? this.chatRoomUid,
    );
  }
}
