import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:firebase_storage/firebase_storage.dart';

import '../error/error.dart';

class FirebaseAuthService {
  Future<void> signUp({
    required firebaseAuth.FirebaseAuth firebaseAuthentication,
    required String username,
    required String email,
    required String password,
    required File imageFile,
  }) async {
    try {
      final firebaseAuth.UserCredential userCredential =
          await firebaseAuthentication.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredential.user!;
      final ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child('${signedInUser.uid}.jpg');

      TaskSnapshot imageUploadTaskSnapShot = await ref.putFile(imageFile);
      String imageUrl = await imageUploadTaskSnapShot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(signedInUser.uid)
          .set({
        'uid': signedInUser.uid,
        'username': username,
        'email': email,
        'imageUrl': imageUrl,
      });
    } on firebaseAuth.FirebaseAuthException catch (firebaseException) {
      throw CustomError(
        httpStatusCode: HttpStatus.internalServerError,
        message:
            'code : ${firebaseException.code} || message : ${firebaseException.message} || plugin : ${firebaseException.plugin}',
      );
    } catch (exception) {
      throw CustomError(
        httpStatusCode: HttpStatus.internalServerError,
        message: '{signUp error : ${exception.toString()}',
      );
    }
  }

  Future<void> signIn({
    required firebaseAuth.FirebaseAuth firebaseAuthentication,
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuthentication.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebaseAuth.FirebaseAuthException catch (firebaseException) {
      throw CustomError(
        httpStatusCode: HttpStatus.internalServerError,
        message:
            'code : ${firebaseException.code} || message : ${firebaseException.message} || plugin : ${firebaseException.plugin}',
      );
    } catch (exception) {
      throw CustomError(
        httpStatusCode: HttpStatus.internalServerError,
        message: '{signIn error : ${exception.toString()}',
      );
    }
  }

  Future<void> signOut({
    required firebaseAuth.FirebaseAuth firebaseAuthentication,
  }) async {
    await firebaseAuthentication.signOut();
  }
}
