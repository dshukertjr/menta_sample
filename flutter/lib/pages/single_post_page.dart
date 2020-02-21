import 'package:flutter/material.dart';
import 'package:sample/models/post.dart';
import 'package:sample/models/user.dart';
import 'package:sample/widgets/post_cell.dart';

class SinglePostPage extends StatelessWidget {
  final Post post;
  final User user;

  const SinglePostPage({
    Key key,
    @required this.post,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('投稿'),
      ),
      body: SingleChildScrollView(
        child: PostCell(post: post, user: user),
      ),
    );
  }
}
