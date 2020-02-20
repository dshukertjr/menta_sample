import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sample/models/post.dart';
import 'package:sample/widgets/post_image.dart';
import 'package:sample/widgets/profile_image.dart';

class PostCell extends StatelessWidget {
  const PostCell(
    this.post, {
    Key key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ProfileImage(
                    user: post.user,
                  ),
                  SizedBox(width: 12),
                  Text(post.user.name),
                ],
              ),
              Text(post.text),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: PostImage(post: post),
        ),
      ],
    );
  }
}
