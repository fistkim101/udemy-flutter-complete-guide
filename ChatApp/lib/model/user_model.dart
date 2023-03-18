import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String? imageUrl;
  final Map<String, String> chatRooms;

  const UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.imageUrl,
    required this.chatRooms,
  });

  factory UserModel.fromDocument(DocumentSnapshot userDocumentSnapshot) {
    Map<String, dynamic> user =
        userDocumentSnapshot.data() as Map<String, dynamic>;
    if (user.containsKey('imageUrl')) {
      return UserModel(
        uid: userDocumentSnapshot.id,
        username: user['username'],
        email: user['email'],
        imageUrl: user['imageUrl'],
        chatRooms: {},
      );
    }

    return UserModel(
      uid: userDocumentSnapshot.id,
      username: user['username'],
      email: user['email'],
      chatRooms: {},
    );
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, username: $username, email: $email, imageUrl: $imageUrl, chatRooms: $chatRooms}';
  }
}
