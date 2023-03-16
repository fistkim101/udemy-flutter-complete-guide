import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../widget/widget.dart';

class ChatRoomsScreen extends StatefulWidget {
  static String routeName = '/chat-rooms';

  const ChatRoomsScreen({super.key});

  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chat Rooms',
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<AuthProvider>().signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
    );
  }
}
