import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.latoTextTheme(),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    toolbarTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primaryColorDark: const Color(0xFFFEDBD0),
    accentColor: const Color.fromARGB(255, 6, 236, 67),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.green,
      onPrimary: Colors.white,
      onSurface: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
);
