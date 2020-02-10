import 'package:flutter/foundation.dart';
import 'package:sample/models/user.dart';

class Post {
  final User user;
  final String imageUrl;
  final String text;
  final int likeCount;
  final bool haveLiked;

  Post({
    @required this.user,
    @required this.imageUrl,
    @required this.text,
    @required this.likeCount,
    @required this.haveLiked,
  });
}
