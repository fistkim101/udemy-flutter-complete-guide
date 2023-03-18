import 'package:chat_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/enum.dart';
import '../provider/provider.dart';
import '../screen/screen.dart';
import '../util/util.dart';
import '../widget/widget.dart';

class FindUserScreen extends StatefulWidget {
  static String routeName = '/find-user';

  const FindUserScreen({super.key});

  @override
  _FindUserScreenState createState() => _FindUserScreenState();
}

class _FindUserScreenState extends State<FindUserScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final Debounce _debounce = Debounce(milliseconds: 1000);

  @override
  void dispose() async {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UsersState usersState = context.watch<UsersState>();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Find user',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildSearchUserTextField(context),
            const SizedBox(
              height: 15,
            ),
            _buildTargetUsers(context, usersState),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchUserTextField(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      decoration: const InputDecoration(
        labelText: 'Find user by username',
        prefixIcon: Icon(
          Icons.search,
        ),
      ),
      autocorrect: false,
      textAlign: TextAlign.left,
      onChanged: (String? username) {
        if (username == null) {
          return;
        }
        _debounce.run(() async {
          String currentUserUid = context.read<AuthState>().currentUser!.uid;
          await context
              .read<UsersProvider>()
              .getAddTargetUsers(username, currentUserUid);
        });
      },
    );
  }

  Widget _buildTargetUsers(BuildContext context, UsersState usersState) {
    if (usersState.progressType == ProgressType.processing) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: usersState.addTargetUsers.length,
        itemBuilder: (context, index) {
          UserModel counterPartUser = usersState.addTargetUsers[index];
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
                FocusScope.of(context).unfocus();
                _textEditingController.clear();

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
      ),
    );
  }
}
