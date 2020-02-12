import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:sample/pages/compose_post_page.dart';
import 'package:sample/pages/edit_profile_page.dart';
import 'package:sample/repositories/user_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ホーム'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => EditProfileBloc(
                        profileRepository:
                            RepositoryProvider.of<UserRepository>(context),
                      )..add(LoadUserProfileEvent()),
                      child: EditProfilePage(),
                    ),
                  ));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              (context),
              MaterialPageRoute(
                builder: (context) => ComposePostPage(),
              ));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
