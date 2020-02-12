import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample/models/user.dart';

class FirestoreProvider {
  final _firestore = Firestore.instance;

  Future<DocumentSnapshot> getUserDoc(String uid) {
    return _firestore.document('users/$uid').get();
  }

  Stream<DocumentSnapshot> userDocStream(String uid) {
    return _firestore.document('users/$uid').snapshots();
  }

  Future<void> updateProfile(User user) {
    return _firestore
        .document('users/${user.uid}')
        .setData(user.toMap(), merge: true);
  }

  Stream<QuerySnapshot> posts(int limit) {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots();
  }
}
