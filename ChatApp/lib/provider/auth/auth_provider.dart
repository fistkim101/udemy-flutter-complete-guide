import 'dart:io';

import 'package:chat_app/constant/constant.dart';
import 'package:chat_app/error/custom_error.dart';
import 'package:chat_app/model/model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:state_notifier/state_notifier.dart';

import '../../enum/enum.dart';
import '../../service/service.dart';
import 'auth_state.dart';

class AuthProvider extends StateNotifier<AuthState> with LocatorMixin {
  final FirebaseAuthService firebaseAuthService;
  final firebaseAuth.FirebaseAuth firebaseAuthentication;

  AuthProvider({
    required this.firebaseAuthService,
    required this.firebaseAuthentication,
  }) : super(AuthState.initial());

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required File? imageFile,
  }) async {
    try {
      await firebaseAuthService.signUp(
        firebaseAuthentication: firebaseAuthentication,
        username: username,
        email: email,
        password: password,
        imageFile: imageFile,
      );
    } on firebaseAuth.FirebaseAuthException catch (firebaseException) {
      throw CustomError.fromFirebaseException(
          firebaseAuthException: firebaseException);
    } catch (exception) {
      throw const CustomError(
        title: '회원 가입 오류',
        message: '다시 시도 해주세요.',
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    firebaseAuthService.signIn(
      firebaseAuthentication: firebaseAuthentication,
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    firebaseAuthService.signOut(firebaseAuthentication: firebaseAuthentication);
  }

  Future<void> syncUser() async {
    UserModel? currentUser;
    await usersCollection.doc(state.currentUser!.uid).get().then((result) {
      currentUser = UserModel.fromDocument(result);
    });

    state = state.copyWith(currentUser: currentUser);
  }

  @override
  void update(Locator watch) async {
    final firebaseAuth.User? user = watch<firebaseAuth.User?>();
    if (user == null) {
      state = state.copyWith(authStatusType: AuthStatusType.unAuthenticated);
      return;
    } else {
      UserModel? currentUser;
      await usersCollection.doc(user.uid).get().then((result) {
        currentUser = UserModel.fromDocument(result);
      });

      state = state.copyWith(
        authStatusType: AuthStatusType.authenticated,
        user: user,
        currentUser: currentUser,
      );
    }

    super.update(watch);
  }
}
