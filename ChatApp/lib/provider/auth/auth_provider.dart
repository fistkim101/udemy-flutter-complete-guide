import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:state_notifier/state_notifier.dart';

import '../../enum/enum.dart';
import '../../service/service.dart';
import 'auth_state.dart';

class AuthProvider extends StateNotifier<AuthState> with LocatorMixin {
  final FirebaseAuthService firebaseAuthService;

  AuthProvider({required this.firebaseAuthService})
      : super(AuthState.initial());

  Future<void> signUp({
    required firebaseAuth.FirebaseAuth firebaseAuthentication,
    required String username,
    required String email,
    required String password,
    required File imageFile,
  }) async {
    firebaseAuthService.signUp(
      firebaseAuthentication: firebaseAuthentication,
      username: username,
      email: email,
      password: password,
      imageFile: imageFile,
    );
  }

  Future<void> signIn({
    required firebaseAuth.FirebaseAuth firebaseAuthentication,
    required String email,
    required String password,
  }) async {
    firebaseAuthService.signIn(
      firebaseAuthentication: firebaseAuthentication,
      email: email,
      password: password,
    );
  }

  Future<void> signOut({
    required firebaseAuth.FirebaseAuth firebaseAuthentication,
  }) async {
    firebaseAuthService.signOut(firebaseAuthentication: firebaseAuthentication);
  }

  @override
  void update(Locator watch) {
    final firebaseAuth.User? user = watch<firebaseAuth.User?>();
    if (user == null) {
      state = state.copyWith(authStatusType: AuthStatusType.unAuthenticated);
      return;
    }

    state = state.copyWith(
      authStatusType: AuthStatusType.authenticated,
      user: user,
    );

    super.update(watch);
  }
}
