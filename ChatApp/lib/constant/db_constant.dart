import 'package:cloud_firestore/cloud_firestore.dart';

final usersCollection = FirebaseFirestore.instance.collection('users');
final chatRoomsCollection = FirebaseFirestore.instance.collection('chatRooms');
