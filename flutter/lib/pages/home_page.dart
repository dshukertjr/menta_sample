import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/home/home_bloc.dart';
import 'package:sample/widgets/post_cell.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
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
            final user = state.user;
            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostCell(
                  post: post,
                  user: user,
                );
              },
              itemCount: posts.length,
            );
          } else if (state is LoadingMoreState) {
            final posts = state.posts;
            final user = state.user;
            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final post = posts[index];
                return PostCell(
                  post: post,
                  user: user,
                );
              },
              itemCount: posts.length + 1,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 300) {
      BlocProvider.of<HomeBloc>(context).add(LoadMorePostsEvent());
    }
  }
}
