import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

class Post extends Equatable {
  final String id;
  final User user;
  final String imageUrl;
  final String text;
  final List<String> likeArray;
  final DateTime createdAt;

  Post({
    this.id,
    this.user,
    this.imageUrl,
    this.text,
    this.likeArray,
    this.createdAt,
  });

  @override
  List<Object> get props => [
        id,
        user,
        imageUrl,
        text,
        likeArray,
        createdAt,
      ];

  static Post fromSnap(DocumentSnapshot snap) {
    return Post(
      id: snap.documentID,
      user: User.fromJson(snap.data['user'] as Map),
      imageUrl: snap.data['imageUrl'] as String,
      text: snap.data['text'] as String,
      likeArray: List<String>.from(snap.data['likeArray']),
      createdAt: snap.data['createdAt']?.toDate() as DateTime,
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      'user': user.toPostDoc(),
      'imageUrl': imageUrl,
      'text': text,
      'likeArray': likeArray ?? [],
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}

extension on User {
  Map<String, dynamic> toPostDoc() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'uid': uid,
    };
  }
}
