import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:sample/bloc/utilities/common_function.dart';
import 'package:sample/bloc/widgets/post/post_bloc.dart';
import 'package:sample/widgets/post_image.dart';
import 'package:sample/widgets/profile_image.dart';
import 'package:user_repository/user_repository.dart';

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
    final liked = post.likeArray.contains(user?.uid);
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
                  post.createdAt == null
                      ? Container()
                      : Text(
                          CommonFunction.timeAgo(post.createdAt),
                          style: TextStyle(color: Colors.grey),
                        ),
                  if (user?.uid == post.user?.uid)
                    PopupMenuButton<String>(
                      onSelected: (val) {
                        if (val == 'delete') {
                          BlocProvider.of<PostBloc>(context)
                              .add(DeletePostEvent(post.id));
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkResponse(
              onTap: () {
                if (liked) {
                  BlocProvider.of<PostBloc>(context)
                      .add(UnlikedPostEvent(post.id));
                } else {
                  BlocProvider.of<PostBloc>(context)
                      .add(LikedPostEvent(post.id));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      color: liked ? Colors.pink : Colors.grey,
                    ),
                    if (post.likeArray.length > 0)
                      Text(post.likeArray.length.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
