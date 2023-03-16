import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseAuthService {
  Future<void> signUp({
    required firebaseAuth.FirebaseAuth firebaseAuthentication,
    required String username,
    required String email,
    required String password,
    required File imageFile,
  }) async {
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
  }

  Future<void> signIn({
    required firebaseAuth.FirebaseAuth firebaseAuthentication,
    required String email,
    required String password,
  }) async {
    await firebaseAuthentication.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut({
    required firebaseAuth.FirebaseAuth firebaseAuthentication,
  }) async {
    await firebaseAuthentication.signOut();
  }
}
