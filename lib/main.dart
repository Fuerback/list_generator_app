import 'package:flutter/material.dart';
import 'package:list_generator/app/views/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Generator App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
                primaryColor: Colors.lightBlue[900],
                backgroundColor: Colors.lightBlue[900],
                scaffoldBackgroundColor: Colors.lightBlue[900],
                buttonColor: Colors.lightBlue[900],
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.blue[900]))
            .copyWith(canvasColor: Colors.transparent),
        home: HomeView());
  }
}
