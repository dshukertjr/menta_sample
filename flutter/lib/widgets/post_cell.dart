import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/models/post.dart';
import 'package:sample/models/user.dart';
import 'package:sample/repositories/post_repository.dart';
import 'package:sample/widgets/post_image.dart';
import 'package:sample/widgets/profile_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCell extends StatelessWidget {
  final Post post;
  final User user;

  const PostCell({
    Key key,
    @required this.post,
    @required this.user,
  }) : super(key: key);

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
                  Expanded(child: Text(post.user.name)),
                  Text(
                    timeago.format(post.createdAt, locale: 'en_short'),
                    style: TextStyle(color: Colors.grey),
                  ),
                  if (user?.uid == post.user?.uid)
                    PopupMenuButton<String>(
                      onSelected: (val) {
                        if (val == 'delete') {
                          RepositoryProvider.of<PostRepository>(context)
                              .deletePost(post);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('投稿の削除が完了しました'),
                          ));
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<String>(
                            child: Text('削除する'),
                            value: 'delete',
                          ),
                        ];
                      },
                    ),
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
