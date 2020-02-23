import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/models/post.dart';
import 'package:sample/models/user.dart';

class FirestoreProvider {
  final _firestore = Firestore.instance;

  Future<DocumentSnapshot> getUserDoc(String uid) {
    return _firestore.document('users/$uid').get();
  }

  Stream<DocumentSnapshot> userDocStream(String uid) {
    return _firestore.document('users/$uid').snapshots();
  }

  Future<DocumentSnapshot> userDoc(String uid) {
    return _firestore.document('users/$uid').get();
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

  String getNewPostDocumentId() {
    return _firestore.collection('posts').document().documentID;
  }

  Future<void> submitPost({
    @required Post post,
    @required String documentId,
  }) async {
    return _firestore
        .document('posts/$documentId')
        .setData(post.toMap(), merge: true);
  }

  Stream<QuerySnapshot> userPostsStream(String uid) {
    return _firestore
        .collection('posts')
        .where('user.uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deletePost(String postId) {
    return _firestore.document('posts/$postId').delete();
  }

  Future<void> likePost({
    @required String postId,
    @required String uid,
  }) {
    return _firestore.document('posts/$postId').setData({
      'likeArray': FieldValue.arrayUnion([uid])
    }, merge: true);
  }

  Future<void> unlikePost({
    @required String postId,
    @required String uid,
  }) {
    return _firestore.document('posts/$postId').setData({
      'likeArray': FieldValue.arrayRemove([uid])
    }, merge: true);
  }

  Stream<DocumentSnapshot> postStream(String postId) {
    return _firestore.document('posts/$postId').snapshots();
  }
}
