import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/pages/edit_profile/edit_profile_bloc.dart';
import 'package:sample/bloc/pages/profile/profile_bloc.dart';
import 'package:sample/bloc/pages/single_post/single_post_bloc.dart';
import 'package:sample/pages/edit_profile_page.dart';
import 'package:sample/pages/single_post_page.dart';
import 'package:sample/repositories/post_repository.dart';
import 'package:sample/repositories/user_repository.dart';
import 'package:sample/widgets/post_image.dart';
import 'package:sample/widgets/profile_image.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('プロフィール'),
        actions: <Widget>[
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is LoadedProfileState && state.isTheirOwnProfile) {
                return FlatButton(
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<EditProfileBloc>(
                          create: (context) => EditProfileBloc(
                            userRepository:
                                RepositoryProvider.of<UserRepository>(context),
                          ),
                          child: EditProfilePage(
                            user: state.user,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text('編集する'),
                );
              }
              return Container();
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedProfileState) {
            final user = state.user;
            final posts = state.posts;
            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ProfileImage(
                                  user: user,
                                  size: 100,
                                  onTap: () {}, // タップしても他のページにいかないようにからのメソッドが必要
                                ),
                                SizedBox(width: 12),
                                Text(
                                  user?.name ?? '',
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(user?.profile ?? ''),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = posts[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<SinglePostBloc>(
                                create: (context) => SinglePostBloc(
                                  postRepository:
                                      RepositoryProvider.of<PostRepository>(
                                          context),
                                )..add(LoadPostEvent(post.id)),
                                child: SinglePostPage(
                                  post: post,
                                  user: user,
                                ),
                              ),
                            ),
                          );
                        },
                        child: PostImage(
                          post: post,
                        ),
                      );
                    },
                    childCount: posts.length,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
