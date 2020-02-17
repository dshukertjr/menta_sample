import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/compose_post/compose_post_bloc.dart';
import 'package:sample/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:sample/bloc/home/home_bloc.dart';
import 'package:sample/pages/compose_post_page.dart';
import 'package:sample/pages/edit_profile_page.dart';
import 'package:sample/pages/home_page.dart';
import 'package:sample/repositories/post_repository.dart';
import 'package:sample/repositories/user_repository.dart';
import 'package:tab_scaffold/tab_scaffold.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ScaffoldTab(
      tabIndex: _tabIndex,
      drawer: Drawer(),
      pages: <Widget>[
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            postRepository: RepositoryProvider.of<PostRepository>(context),
          )..add(SetupHomeEvent()),
          child: HomePage(),
        ),
        BlocProvider(
          create: (context) => ComposePostBloc(
            postRepository: RepositoryProvider.of<PostRepository>(context),
          ),
          child: ComposePostPage(),
        ),
        BlocProvider<EditProfileBloc>(
          create: (context) => EditProfileBloc(
            profileRepository: RepositoryProvider.of<UserRepository>(context),
          )..add(LoadUserProfileEvent()),
          child: EditProfilePage(),
        ),
      ],
      bottomNavigationBar: BottomAppBar(
        child: Builder(builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                color: _tabIndex == 0
                    ? Theme.of(context).accentColor
                    : Colors.black,
                icon: Icon(Icons.home),
                onPressed: () {
                  setState(() {
                    _tabIndex = 0;
                  });
                },
              ),
              IconButton(
                color: _tabIndex == 1
                    ? Theme.of(context).accentColor
                    : Colors.black,
                icon: Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    _tabIndex = 1;
                  });
                },
              ),
              IconButton(
                color: _tabIndex == 2
                    ? Theme.of(context).accentColor
                    : Colors.black,
                icon: Icon(Icons.person),
                onPressed: () {
                  setState(() {
                    _tabIndex = 2;
                  });
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
