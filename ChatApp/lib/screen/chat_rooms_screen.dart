import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/enum.dart';
import '../model/model.dart';
import '../provider/provider.dart';
import '../screen/screen.dart';
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
        customLeading: Container(),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, FindUserScreen.routeName).then(
                  (_) => context.read<UsersProvider>().clearTargetUsers());
            },
            icon: const Icon(
              Icons.add_outlined,
            ),
          ),
          IconButton(
            onPressed: () async {
              await context.read<AuthProvider>().signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          _buildChatRooms(context),
        ],
      ),
    );
  }

  Widget _buildChatRooms(BuildContext context) {
    final ChatRoomState chatRoomState = context.watch<ChatRoomState>();
    if (chatRoomState.progressType == ProgressType.processing) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (chatRoomState.counterPartUsers.isEmpty) {
      return Container();
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: chatRoomState.counterPartUsers.length,
      itemBuilder: (context, index) {
        UserModel counterPartUser = chatRoomState.counterPartUsers[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: ListTile(
            key: ValueKey(counterPartUser.uid),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: counterPartUser.imageUrl != null
                  ? Image.network(
                      counterPartUser.imageUrl!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                    ),
            ),
            title: Text(counterPartUser.username),
            onTap: () async {
              AuthState authState = context.read<AuthState>();
              await context
                  .read<ChatProvider>()
                  .readyToChat(counterPartUser.uid, authState.user!.uid);

              Navigator.pushNamed(
                context,
                ChatDetailScreen.routeName,
                arguments: counterPartUser,
              );
            },
          ),
        );
      },
    );
  }
}
