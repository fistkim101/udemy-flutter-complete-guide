import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum/enum.dart';
import '../provider/provider.dart';
import '../screen/screen.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthState authState = context.watch<AuthState>();

    if ((authState.authStatusType == AuthStatusType.unknown) ||
        authState.authStatusType == AuthStatusType.unAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, SignInScreen.routeName);
      });
    }

    if (authState.authStatusType == AuthStatusType.authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, ChatRoomsScreen.routeName);
      });
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
