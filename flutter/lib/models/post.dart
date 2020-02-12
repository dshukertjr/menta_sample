import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/models/user.dart';

class Post {
  final User user;
  final String imageUrl;
  final String text;
  final List<String> likeArray;
  final DateTime createdAt;

  Post({
    @required this.user,
    @required this.imageUrl,
    @required this.text,
    @required this.likeArray,
    @required this.createdAt,
  });

  static Post fromSnapshot(DocumentSnapshot snapshot) {
    return Post(
      user: User.fromMap(snapshot.data['user']),
      imageUrl: snapshot.data['imageUrl'],
      text: snapshot.data['text'],
      likeArray: snapshot.data['likeArray'] == null
          ? []
          : snapshot.data['likeArray']
              .map<String>((like) => like.toString())
              .toList(),
      createdAt: snapshot.data['createdAt'] == null
          ? null
          : snapshot.data['createdAt'].toDate(),
    );
  }
}
