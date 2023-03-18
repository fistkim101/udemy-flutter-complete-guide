import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  String? imageUrl;
  Map<String, String>? chatRooms;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.imageUrl,
    this.chatRooms,
  });

  factory UserModel.fromDocument(DocumentSnapshot userDocumentSnapshot) {
    Map<String, dynamic> user =
        userDocumentSnapshot.data() as Map<String, dynamic>;

    UserModel convetedUser = UserModel(
      uid: userDocumentSnapshot.id,
      username: user['username'],
      email: user['email'],
    );

    if (user.containsKey('imageUrl')) {
      convetedUser.imageUrl = user['imageUrl'];
    }

    if (user.containsKey('chatRooms')) {
      Map<String, String> chatRooms = {};
      (user['chatRooms'] as Map<String, dynamic>).forEach((key, value) {
        chatRooms[key] = value.toString();
      });
      convetedUser.chatRooms = chatRooms;
    }

    return convetedUser;
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, username: $username, email: $email, imageUrl: $imageUrl, chatRooms: $chatRooms}';
  }
}
