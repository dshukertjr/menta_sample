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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile': profile,
      'imageUrl': imageUrl,
      'uid': uid,
    };
  }
}
