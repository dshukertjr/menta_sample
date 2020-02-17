import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/home/home_bloc.dart';
import 'package:sample/pages/home_page.dart';
import 'package:sample/pages/tab_page.dart';
import 'package:sample/repositories/post_repository.dart';
import 'package:sample/repositories/user_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => PostRepository()),
      ],
      child: MaterialApp(
        title: 'Sample',
        theme: ThemeData(
          primaryColor: Colors.orange,
          primaryColorBrightness: Brightness.dark,
          accentColor: Colors.lightBlue,
          accentColorBrightness: Brightness.dark,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
          ),
        ),
        home: TabPage(),
      ),
    );
  }
}
