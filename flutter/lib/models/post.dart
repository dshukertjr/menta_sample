import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/models/user.dart';

class Post {
  final String id;
  final User user;
  final String imageUrl;
  final String text;
  final List<String> likeArray;
  final DateTime createdAt;

  Post({
    @required this.id,
    @required this.user,
    @required this.imageUrl,
    @required this.text,
    @required this.likeArray,
    this.createdAt,
  });

  static Post fromSnapshot(DocumentSnapshot snapshot) {
    return Post(
      id: snapshot.documentID,
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

  Post copyWith({
    String id,
    User user,
    String imageUrl,
    String text,
    List<String> likeArray,
    DateTime createdAt,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      imageUrl: imageUrl ?? this.imageUrl,
      text: text ?? this.text,
      likeArray: likeArray ?? this.likeArray,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'imageUrl': imageUrl,
      'text': text,
      'likeArray': [],
      'createdAt': createdAt == null ? FieldValue.serverTimestamp() : createdAt,
    };
  }
}
