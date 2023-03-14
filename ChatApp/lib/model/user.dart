import 'model.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final String imageUrl;
  final List<ChatRoom> chatRooms;

  const User({
    required this.uid,
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.chatRooms,
  });
}
