import 'package:flutter/material.dart';
import 'package:covid19_app/screen/home.dart';
import 'package:covid19_app/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19 App',
      theme: ThemeData(
        primaryColor: mainColor,
        scaffoldBackgroundColor: lightColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: textColor),
        fontFamily: 'Poppins',
      ),
      home: Home(),
    );
  }
}
