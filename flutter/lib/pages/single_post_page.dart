import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:sample/bloc/pages/single_post/single_post_bloc.dart';
import 'package:sample/bloc/widgets/post/post_bloc.dart';
import 'package:sample/widgets/post_cell.dart';
import 'package:user_repository/user_repository.dart';

class SinglePostPage extends StatelessWidget {
  static PageRoute<dynamic> route({
    @required Post post,
    @required User user,
  }) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<SinglePostBloc>(
        create: (context) => SinglePostBloc(
          postRepository: RepositoryProvider.of<PostRepository>(context),
        )..add(LoadPostEvent(post.id)),
        child: SinglePostPage(
          post: post,
          user: user,
        ),
      ),
    );
  }

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
        child: BlocProvider(
          create: (context) => PostBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            postRepository: RepositoryProvider.of<PostRepository>(context),
          ),
          child: BlocBuilder<SinglePostBloc, SinglePostState>(
              builder: (context, state) {
            if (state is LoadedPostState) {
              return PostCell(post: state.post, user: user);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }
}
