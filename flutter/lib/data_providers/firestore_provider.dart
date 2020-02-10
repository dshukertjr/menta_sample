import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample/models/user.dart';

class FirestoreProvider {
  final _firestore = Firestore.instance;

  Future<void> updateProfile(User user) {
    return _firestore
        .document('users/${user.uid}')
        .setData(user.toMap(), merge: true);
  }
}
