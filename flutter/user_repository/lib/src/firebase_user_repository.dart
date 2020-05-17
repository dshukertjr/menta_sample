import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import './user_repository.dart';
import 'models/user.dart';

class FirebaseUserRepository implements UserRepository {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;
  static final _storage = FirebaseStorage.instance;

  @override
  Future<String> getUid() async {
    return (await _auth.currentUser()).uid;
  }

  @override
  Future<User> getUser() async {
    final uid = getUid();
    final doc = await _firestore.document('users/$uid').get();
    return User.fromSnap(doc);
  }

  @override
  Stream<FirebaseUser> onAuthStateChanged() {
    return _auth.onAuthStateChanged;
  }

  @override
  Future<void> saveUserProfile(User user) async {
    final uid = await getUid();
    return _firestore.document('users/$uid').setData(user.toDoc(), merge: true);
  }

  @override
  Future<String> uploadProfileImage(File imageFile) async {
    final uid = await getUid();
    final ref = _storage.ref().child('users/$uid/profile');
    final task = ref.putFile(imageFile);
    await task.onComplete;
    return ref.getDownloadURL() as Future<String>;
  }

  @override
  Stream<User> userStream(String uid) {
    return _firestore
        .document('users/$uid')
        .snapshots()
        .map((snap) => User.fromSnap(snap));
  }
}
