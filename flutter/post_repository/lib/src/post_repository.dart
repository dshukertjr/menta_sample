import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';

import 'models/post.dart';

abstract class PostRepository {
  Stream<List<Post>> postsStream();

  Future<void> submitPost({
    @required File imageFile,
    @required String text,
    @required User user,
  });

  Stream<List<Post>> userPostsStream(String uid);

  Future<void> deletePost(String postId);

  Future<void> likePost({@required String postId, @required String uid});

  Future<void> unlikePost({@required String postId, @required String uid});

  Stream<Post> postStream(String postId);
}
