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

  int _postLimit = 10;

  Stream<List<Post>> postsStream() {
    return _firestoreProvider.posts(_postLimit).map<List<Post>>(
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
}
