import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../constant/constant.dart';
import '../../enum/enum.dart';
import '../../model/model.dart';
import 'users_state.dart';

class UsersProvider extends StateNotifier<UsersState> {
  UsersProvider() : super(UsersState.initial());

  Future<void> getAddTargetUsers(String username, String currentUserUid) async {
    state = state.copyWith(progressType: ProgressType.processing);

    List<UserModel> users = [];
    await usersCollection
        .where('username', isGreaterThanOrEqualTo: username)
        .where('username', isLessThanOrEqualTo: '$username\uf8ff')
        .get()
        .then((result) {
      final List<DocumentSnapshot> userDocuments = result.docs;
      for (var user in userDocuments) {
        if (currentUserUid != user['uid']) {
          users.add(UserModel.fromDocument(user));
        }
      }
    });

    state = state.copyWith(
      addTargetUsers: users,
      progressType: ProgressType.completed,
    );
  }

  Future<void> clearTargetUsers() async {
    state = state.copyWith(
      addTargetUsers: [],
      progressType: ProgressType.initial,
    );
  }
}
