import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
  final String name;
  final String profile;
  final String imageUrl;
  final String uid;

  User({
    @required this.name,
    @required this.profile,
    @required this.imageUrl,
    @required this.uid,
  });

  User.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data == null ? null : snapshot.data['name'],
        profile = snapshot.data == null ? null : snapshot.data['profile'],
        imageUrl = snapshot.data == null ? null : snapshot.data['imageUrl'],
        uid = snapshot.documentID;

  static User fromMap(dynamic map) {
    print('inside user model');

    print(map);

    return User(
      name: map['name'],
      profile: map['profile'],
      imageUrl: map['imageUrl'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile': profile,
      'imageUrl': imageUrl,
      'uid': uid,
    };
  }
}
