import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:post_repository/post_repository.dart';
import 'package:post_repository/src/models/post.dart';
import 'package:user_repository/user_repository.dart';

class FirebasePostRepository implements PostRepository {
  static final _postsCollection = Firestore.instance.collection('posts');
  static final _storage = FirebaseStorage.instance;

  @override
  Future<void> deletePost(String postId) {
    return _postsCollection.document(postId).delete();
  }

  @override
  Future<void> likePost({
    @required String postId,
    @required String uid,
  }) {
    return _postsCollection.document(postId).setData({
      'likeArray': FieldValue.arrayUnion([uid]),
    }, merge: true);
  }

  @override
  Stream<Post> postStream(String postId) {
    return _postsCollection.document(postId).snapshots().map(Post.fromSnap);
  }

  @override
  Stream<List<Post>> postsStream() {
    return _postsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.documents.map(Post.fromSnap).toList());
  }

  @override
  Future<void> submitPost({
    @required File imageFile,
    String text,
    @required User user,
  }) async {
    final postId = _postsCollection.document().documentID;
    final ref = _storage.ref().child('posts/${user.uid}/$postId/post');
    final task = ref.putFile(imageFile);
    final snap = await task.onComplete;
    final imageUrl = await snap.ref.getDownloadURL();
    final post = Post(
      text: text,
      user: user,
      imageUrl: imageUrl,
    );
    return _postsCollection.document(postId).setData(post.toDoc(), merge: true);
  }

  @override
  Future<void> unlikePost({
    @required String postId,
    @required String uid,
  }) {
    return _postsCollection.document(postId).setData({
      'likeArray': FieldValue.arrayRemove([uid]),
    }, merge: true);
  }

  @override
  Stream<List<Post>> userPostsStream(String uid) {
    return _postsCollection
        .where('user.uid', isEqualTo: uid)
        .snapshots()
        .map((snap) => snap.documents.map(Post.fromSnap).toList());
  }
}
