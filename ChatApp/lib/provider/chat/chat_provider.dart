import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../constant/constant.dart';
import '../../enum/enum.dart';
import '../../model/model.dart';
import 'chat_state.dart';

class ChatProvider extends StateNotifier<ChatState> {
  ChatProvider() : super(ChatState.initial());

  Future<void> readyToChat(String counterPartUid, String currentUserUid) async {
    if (state.counterPartUser?.uid == counterPartUid) {
      return;
    }

    state = state.copyWith(progressType: ProgressType.processing);

    final UserModel currentUser = await _getUserModel(currentUserUid);
    final UserModel counterPartUser = await _getUserModel(counterPartUid);

    final String? chatRoomUid = currentUser.chatRooms[counterPartUid];

    state = state.copyWith(
      progressType: ProgressType.completed,
      chatRoomUid: chatRoomUid,
      counterPartUser: counterPartUser,
      currentUser: currentUser,
    );
  }

  Future<void> addChat(String content) async {
    state = state.copyWith(progressType: ProgressType.processing);
    final ChatModel newChat = ChatModel(
      content: content,
      createdAt: Timestamp.now(),
      speakerUid: state.currentUser!.uid,
    );

    String? chatRoomUid = state.chatRoomUid;
    if (chatRoomUid == null) {
      DocumentReference newChatRoomDocument = chatRoomsCollection.doc();

      await chatRoomsCollection.doc(newChatRoomDocument.id).set({
        'chats': FieldValue.arrayUnion([
          {
            'content': newChat.content,
            'createdAt': newChat.createdAt,
            'speakerUid': newChat.speakerUid,
          }
        ]),
      });

      state = state.copyWith(
        progressType: ProgressType.completed,
        chatRoomUid: newChatRoomDocument.id,
      );
      return;
    }

    await chatRoomsCollection.doc(state.chatRoomUid).update({
      'chats': FieldValue.arrayUnion([
        {
          'content': newChat.content,
          'createdAt': newChat.createdAt,
          'speakerUid': newChat.speakerUid,
        }
      ]),
    });
    state = state.copyWith(progressType: ProgressType.completed);
  }

  Future<UserModel> _getUserModel(String uid) async {
    final DocumentSnapshot userDocument = await usersCollection.doc(uid).get();
    return UserModel.fromDocument(userDocument);
  }
}
