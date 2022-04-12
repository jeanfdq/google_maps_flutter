import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff3253a2),
          onPrimary: Colors.white,
          secondary: Color(0xff3253a2),
          onSecondary: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Color(0xff3253a2),
          surface: Color(0xff3253a2),
          onSurface: Colors.white));
}
