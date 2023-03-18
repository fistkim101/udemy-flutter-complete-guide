import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String content;
  final Timestamp createdAt;
  final String speakerUid;

  const ChatModel({
    required this.content,
    required this.createdAt,
    required this.speakerUid,
  });
}
