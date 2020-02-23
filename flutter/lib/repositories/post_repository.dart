import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sample/data_providers/auth_provider.dart';
import 'package:sample/data_providers/firestore_provider.dart';
import 'package:sample/data_providers/storage_provider.dart';
import 'package:sample/models/post.dart';
import 'package:sample/models/user.dart';

class PostRepository {
  final _firestoreProvider = FirestoreProvider();
  final _authProvider = AuthProvider();
  final _storageProvider = StorageProvider();

  int postLimit = 0;
  Stream<List<Post>> postsStream() {
    postLimit += 10;
    return _firestoreProvider.posts(postLimit).map<List<Post>>(
        (snapshot) => snapshot.documents.map<Post>(Post.fromSnapshot).toList());
  }

  Future<void> submitPost({
    @required File imageFile,
    @required String text,
  }) async {
    final firebaseUser = await _authProvider.currentUser();
    final userDocument = await _firestoreProvider.getUserDoc(firebaseUser.uid);
    final user = User.fromMap(userDocument.data);
    final documentId = _firestoreProvider.getNewPostDocumentId();
    final imageUrl = await _storageProvider.uploadPostImage(
        imageFile: imageFile, documentId: documentId, uid: firebaseUser.uid);
    final post = Post(
      id: null,
      imageUrl: imageUrl,
      text: text,
      likeArray: [],
      user: user,
    );
    return _firestoreProvider.submitPost(post: post, documentId: documentId);
  }

  Stream<List<Post>> userPostsStream(String uid) {
    return _firestoreProvider.userPostsStream(uid).map<List<Post>>(
        (snapshot) => snapshot.documents.map<Post>(Post.fromSnapshot).toList());
  }

  Future<void> deletePost(String postId) {
    return _firestoreProvider.deletePost(postId);
  }

  Future<void> likePost(String postId) async {
    final user = await _authProvider.currentUser();
    return _firestoreProvider.likePost(postId: postId, uid: user.uid);
  }

  Future<void> unlikePost(String postId) async {
    final user = await _authProvider.currentUser();
    return _firestoreProvider.unlikePost(postId: postId, uid: user.uid);
  }

  Stream<Post> postStream(String postId) {
    return _firestoreProvider.postStream(postId).map<Post>(Post.fromSnapshot);
  }
}
