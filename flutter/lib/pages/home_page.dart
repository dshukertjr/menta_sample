import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/home/home_bloc.dart';
import 'package:sample/models/post.dart';
import 'package:sample/widgets/profile_image.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ホーム'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is LoadedHomeState) {
            final posts = state.posts;
            final loadingMorePosts = state.loadingMorePosts;
            final user = state.user;
            return ListView.builder(
              itemBuilder: (context, index) {
                final post = posts[index];
                return _HomeCell(post);
              },
              itemCount: posts.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _HomeCell extends StatelessWidget {
  const _HomeCell(
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
          child: Row(
            children: <Widget>[
              ProfileImage(
                user: post.user,
              ),
              SizedBox(width: 12),
              Text(post.user.name),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: post.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
