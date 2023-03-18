import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../constant/constant.dart';
import '../../enum/enum.dart';
import '../../model/model.dart';
import '../../provider/provider.dart';
import 'chat_room_state.dart';

class ChatRoomProvider extends StateNotifier<ChatRoomState> with LocatorMixin {
  ChatRoomProvider() : super(ChatRoomState.initial());

  Future<void> syncChatRooms(String currentUserUid) async {
    state = state.copyWith(progressType: ProgressType.processing);

    UserModel? currentUser;
    await usersCollection.doc(currentUserUid).get().then((result) {
      currentUser = UserModel.fromDocument(result);
    });

    List<UserModel> counterPartUsers = [];
    for (var uid in currentUser!.chatRooms!.keys) {
      UserModel user = await _getUserModel(uid);
      counterPartUsers.add(user);
    }

    state = state.copyWith(
        progressType: ProgressType.completed,
        counterPartUsers: counterPartUsers);
  }

  @override
  void update(Locator watch) async {
    state = state.copyWith(progressType: ProgressType.processing);
    AuthState authState = watch<AuthState>();
    if (authState.authStatusType != AuthStatusType.authenticated) {
      state = ChatRoomState.initial();
      return;
    }

    if (authState.currentUser?.chatRooms == null) {
      state = state.copyWith(progressType: ProgressType.completed);
      return;
    }
    List<UserModel> counterPartUsers = [];
    for (var uid in authState.currentUser!.chatRooms!.keys) {
      UserModel user = await _getUserModel(uid);
      counterPartUsers.add(user);
    }

    state = state.copyWith(
        counterPartUsers: counterPartUsers,
        progressType: ProgressType.completed);
    super.update(watch);
  }

  Future<UserModel> _getUserModel(String uid) async {
    final DocumentSnapshot userDocument = await usersCollection.doc(uid).get();
    return UserModel.fromDocument(userDocument);
  }
}
