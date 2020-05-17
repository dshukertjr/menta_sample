import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:sample/bloc/pages/compose_post/compose_post_bloc.dart';
import 'package:sample/bloc/pages/home/home_bloc.dart';
import 'package:sample/bloc/pages/profile/profile_bloc.dart';
import 'package:sample/bloc/widgets/post/post_bloc.dart';
import 'package:sample/pages/compose_post_page.dart';
import 'package:sample/pages/home_page.dart';
import 'package:sample/pages/profile_page.dart';
import 'package:tab_scaffold/tab_scaffold.dart';
import 'package:user_repository/user_repository.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return TabInherited(
      openTab: (int index) {
        setState(() {
          _tabIndex = index;
        });
      },
      child: ScaffoldTab(
        tabIndex: _tabIndex,
        drawer: Drawer(),
        pages: <Widget>[
          MultiBlocProvider(
            providers: [
              BlocProvider<HomeBloc>(
                create: (context) => HomeBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                  postRepository:
                      RepositoryProvider.of<PostRepository>(context),
                )..add(SetupHomeEvent()),
              ),
              BlocProvider<PostBloc>(
                create: (context) => PostBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                  postRepository:
                      RepositoryProvider.of<PostRepository>(context),
                ),
              ),
            ],
            child: HomePage(),
          ),
          BlocProvider(
            create: (context) => ComposePostBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              postRepository: RepositoryProvider.of<PostRepository>(context),
            ),
            child: ComposePostPage(),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              postRepository: RepositoryProvider.of<PostRepository>(context),
            )..add(LoadProfileEvent(uid: null)),
            child: ProfilePage(),
          ),
        ],
        bottomNavigationBar: _bottomAppBar(),
      ),
    );
  }

  BottomAppBar _bottomAppBar() {
    return BottomAppBar(
      child: Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _bottomAppBarButton(
              context: context,
              iconData: Icons.home,
              index: 0,
              text: 'ホーム',
            ),
            _bottomAppBarButton(
              context: context,
              iconData: Icons.edit,
              index: 1,
              text: '投稿',
            ),
            _bottomAppBarButton(
              context: context,
              iconData: Icons.person,
              index: 2,
              text: 'プロフィール',
            ),
          ],
        );
      }),
    );
  }

  Widget _bottomAppBarButton({
    @required BuildContext context,
    @required int index,
    @required IconData iconData,
    @required String text,
  }) {
    final color =
        _tabIndex == index ? Theme.of(context).accentColor : Colors.black;
    return Expanded(
      child: InkResponse(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(iconData, color: color),
              Text(text, style: TextStyle(color: color, fontSize: 10)),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}

class TabInherited extends InheritedWidget {
  final void Function(int index) openTab;
  final Widget child;

  TabInherited({@required this.openTab, @required this.child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static TabInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TabInherited>();
  }
}
