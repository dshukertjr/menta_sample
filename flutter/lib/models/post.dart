import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/models/user.dart';

class Post {
  final User user;
  final String imageUrl;
  final String text;
  final int likeCount;
  final bool haveLiked;
  final DateTime createdAt;

  Post({
    @required this.user,
    @required this.imageUrl,
    @required this.text,
    @required this.likeCount,
    @required this.haveLiked,
    @required this.createdAt,
  });

  static fromSnapshot(DocumentSnapshot snapshot) {
    return Post(
      user: User.fromMap(snapshot.data['user']),
      imageUrl: snapshot.data['imageUrl'],
      text: snapshot.data['text'],
      likeCount: snapshot.data['likeCount'],
      haveLiked: snapshot.data['haveLiked'],
      createdAt: snapshot.data['createdAt']
          ? null
          : snapshot.data['createdAt'].toDate(),
    );
  }
}
