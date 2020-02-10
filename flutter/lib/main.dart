import 'package:flutter/material.dart';
import 'package:sample/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample',
      theme: ThemeData(
        primaryColor: Colors.orange,
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.lightBlue,
        accentColorBrightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: HomePage(),
    );
  }
}
