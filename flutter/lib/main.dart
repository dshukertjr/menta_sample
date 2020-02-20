import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/pages/tab_page.dart';
import 'package:sample/repositories/post_repository.dart';
import 'package:sample/repositories/user_repository.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

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

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('$error, $stacktrace');
  }
}
