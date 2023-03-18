import 'package:chat_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';
import '../provider/provider.dart';
import '../widget/widget.dart';

class ChatDetailScreen extends StatefulWidget {
  static String routeName = '/chat-detail';

  const ChatDetailScreen({super.key});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel counterPartUser =
        ModalRoute.of(context)?.settings.arguments as UserModel;

    AuthState authState = context.read<AuthState>();
    context
        .read<ChatProvider>()
        .readyToChat(counterPartUser.uid, authState.user!.uid);

    ChatState chatState = context.watch<ChatState>();

    return Scaffold(
      appBar: CustomAppBar(
        title: counterPartUser.username,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          chatState.chatRoomUid == null
              ? Container()
              : StreamBuilder(
                  stream: chatRoomsCollection
                      .doc(chatState.chatRoomUid)
                      .snapshots(),
                  builder: (context, chatSnapshot) {
                    if (chatSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final rawChats = (chatSnapshot.data!.data()
                        as Map<String, dynamic>)['chats'] as List<dynamic>;
                    final List<ChatModel> chats = rawChats.map((chat) {
                      return ChatModel(
                        content: chat['content'],
                        createdAt: chat['createdAt'],
                        speakerUid: chat['speakerUid'],
                      );
                    }).toList();
                    chats.sort((a, b) => a.createdAt.compareTo(b.createdAt));

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        return Text(chats[index].content);
                      },
                    );
                  },
                ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    onSubmitted: (String? content) {
                      if (content == null || content == '') {
                        return;
                      }

                      context.read<ChatProvider>().addChat(content);
                      _textEditingController.clear();
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    String content = _textEditingController.text;
                    if (content == '') {
                      return;
                    }

                    context.read<ChatProvider>().addChat(content);
                    _textEditingController.clear();
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
