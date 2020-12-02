import 'package:flutter/material.dart';

class MainTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueGrey,
    accentColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline2: TextStyle(
          fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline3: TextStyle(fontSize: 32.0, color: Colors.white),
      headline4: TextStyle(fontSize: 28.0, color: Colors.white),
      headline5: TextStyle(fontSize: 24.0, color: Colors.white),
      headline6: TextStyle(fontSize: 20.0, color: Colors.white),
      bodyText1: TextStyle(fontSize: 16.0, color: Colors.white),
      bodyText2: TextStyle(fontSize: 14.0, color: Colors.white),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue,
    accentColor: Colors.deepPurple,
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline2: TextStyle(
          fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline3: TextStyle(fontSize: 32.0, color: Colors.white),
      headline4: TextStyle(fontSize: 28.0, color: Colors.white),
      headline5: TextStyle(fontSize: 24.0, color: Colors.white),
      headline6: TextStyle(fontSize: 20.0, color: Colors.white),
      bodyText1: TextStyle(fontSize: 16.0, color: Colors.white),
      bodyText2: TextStyle(fontSize: 14.0, color: Colors.white),
    ),
  );
}
