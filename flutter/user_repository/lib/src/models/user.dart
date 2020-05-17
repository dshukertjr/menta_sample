import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String profile;
  final String imageUrl;
  final String uid;

  User({this.name, this.profile, this.imageUrl, this.uid});

  @override
  List<Object> get props => [name, profile, imageUrl, uid];

  User copyWith({
    String name,
    String profile,
    String imageUrl,
    String uid,
  }) {
    return User(
      name: name ?? this.name,
      profile: profile ?? this.profile,
      imageUrl: imageUrl ?? this.imageUrl,
      uid: uid ?? this.uid,
    );
  }

  static User fromSnap(DocumentSnapshot snap) {
    return User(
      name: (snap.data ?? {})['name'],
      profile: (snap.data ?? {})['profile'],
      imageUrl: (snap.data ?? {})['imageUrl'],
      uid: snap.documentID,
    );
  }

  static User fromJson(Map map) {
    return User(
      name: map['name'],
      profile: map['profile'],
      imageUrl: map['imageUrl'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      'name': name,
      'profile': profile,
      'imageUrl': imageUrl,
    };
  }
}
