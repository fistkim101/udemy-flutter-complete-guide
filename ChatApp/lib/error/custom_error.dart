import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

class CustomError {
  final String title;
  final String message;

  const CustomError({
    required this.title,
    required this.message,
  });

  factory CustomError.fromFirebaseException({
    required firebaseAuth.FirebaseAuthException firebaseAuthException,
  }) {
    if (firebaseAuthException.code == 'weak-password') {
      return const CustomError(
        title: '회원 가입 오류',
        message: '비밀번호는 6자 이상이어야 합니다.',
      );
    }

    if (firebaseAuthException.code == 'email-already-in-use') {
      return const CustomError(
        title: '회원 가입 오류',
        message: '이미 사용중인 이메일 주소입니다. 다른 이메일 주소로 가입해주세요.',
      );
    }

    return const CustomError(
      title: '회원 가입 오류',
      message: '다시 시도해주세요.',
    );
  }

  @override
  String toString() {
    return 'CustomError{message: $message}';
  }
}
