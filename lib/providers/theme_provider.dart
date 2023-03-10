import 'package:flutter/material.dart';

class ThemeClass {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.cyan,
      titleTextStyle: TextStyle(color: Colors.black87, fontSize: 16),
      iconTheme: IconThemeData(color: Colors.black87),
    ),
    primaryColor: Colors.cyan,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: Colors.grey.shade100, onPrimary: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color.fromARGB(255, 40, 40, 40),
    iconTheme: IconThemeData(color: Colors.white70),
    backgroundColor: Colors.black54,
    appBarTheme: AppBarTheme(
      color: Color.fromARGB(255, 49, 49, 49),
      titleTextStyle: TextStyle(color: Colors.white70, fontSize: 16),
      iconTheme: IconThemeData(color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: Colors.grey, onPrimary: Colors.black),
    ),
  );
}
