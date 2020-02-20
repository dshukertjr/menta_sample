import 'package:flutter/material.dart';
import 'package:sample/models/post.dart';
import 'package:sample/widgets/post_cell.dart';

class SinglePostPage extends StatelessWidget {
  final Post post;

  const SinglePostPage({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('投稿'),
      ),
      body: SingleChildScrollView(
        child: PostCell(post),
      ),
    );
  }
}
