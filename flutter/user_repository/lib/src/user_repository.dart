import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../user_repository.dart';

abstract class UserRepository {
  Stream<FirebaseUser> onAuthStateChanged();

  Future<String> getUid();

  Future<void> signInIfNotSignedIn();

  Future<User> getUser();

  Future<void> saveUserProfile(User user);

  Stream<User> userStream(String uid);

  Future<String> uploadProfileImage(File imageFile);
}
