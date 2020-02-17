import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/home/home_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ホーム'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is LoadedHomeState) {
          final posts = state.posts;
          final loadingMorePosts = state.loadingMorePosts;
          final user = state.user;
          return ListView.builder(
            itemBuilder: (context, index) {
              final post = posts[index];
              return Text(post.text);
            },
            itemCount: posts.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
