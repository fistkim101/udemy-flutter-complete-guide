import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firbaseAuth;

import '../../enum/enum.dart';
import '../../model/model.dart';

class AuthState extends Equatable {
  final AuthStatusType authStatusType;
  final firbaseAuth.User? user;
  final UserModel? currentUser;

  const AuthState({
    required this.authStatusType,
    this.user,
    this.currentUser,
  });

  factory AuthState.initial() {
    return const AuthState(authStatusType: AuthStatusType.unknown);
  }

  @override
  List<Object?> get props => [authStatusType, user, currentUser];

  @override
  String toString() {
    return 'AuthState{authStatusType: $authStatusType, user: $user, currentUser: $currentUser}';
  }

  AuthState copyWith({
    AuthStatusType? authStatusType,
    firbaseAuth.User? user,
    UserModel? currentUser,
  }) {
    return AuthState(
      authStatusType: authStatusType ?? this.authStatusType,
      user: user ?? this.user,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
