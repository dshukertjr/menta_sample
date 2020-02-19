import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/profile/profile_bloc.dart';
import 'package:sample/widgets/profile_image.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('プロフィール'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedProfileState) {
            final user = state.user;
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
                                ProfileImage(user: user),
                                SizedBox(width: 12),
                                Text(
                                  user.name ?? '',
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(user.profile ?? ''),
                          ],
                        ),
                      ),
                    ],
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
