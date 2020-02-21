import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/home/home_bloc.dart';
import 'package:sample/models/post.dart';
import 'package:sample/widgets/post_cell.dart';
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
                return PostCell(
                  post: post,
                  user: user,
                );
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
