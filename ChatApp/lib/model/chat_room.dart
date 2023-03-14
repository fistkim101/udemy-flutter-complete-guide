import 'model.dart';

class ChatRoom {
  final List<User> users;
  final List<Chat> chats;

  const ChatRoom({
    required this.users,
    required this.chats,
  });
}
