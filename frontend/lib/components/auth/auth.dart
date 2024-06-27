import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

//responsible for connecting to firebase, but we used our own backend so we dont use it

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      {required email, required String password}) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return credentials.user;
    } catch (e) {
      log("something went wrong when creating user");
    }
    return null;
  }

  Future<User?> logInUserWithEmailAndPassword(
      {required email, required String password}) async {
    log("$email $password");
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return credentials.user;
    } catch (e) {
      log("something went wrong when signin in");
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("something went wrong when signing out");
    }
  }
}
