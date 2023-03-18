import 'package:cloud_firestore/cloud_firestore.dart';
import 'model.dart';

class ChatRoomModel {
  final List<UserModel> users;
  final List<ChatModel> chats;

  const ChatRoomModel({
    required this.users,
    required this.chats,
  });

// factory ChatRoomModel.fromDocument(DocumentSnapshot chatRoomDocumentSnapshot){
//   final chatRooms = chatRoomDocumentSnapshot.data() as Map<String, dynamic>;
//   final users = chatRooms['users'] as List<dynamic>;
//   final chats = chatRooms['chats'] as List<dynamic>;
//   return ChatRoomModel(users: users.map((user) => UserModel.fromDocument(userDocumentSnapshot)), chats: chats)
// }

}
