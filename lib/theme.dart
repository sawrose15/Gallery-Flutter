import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.latoTextTheme(),
  scaffoldBackgroundColor: const Color(0xFF393838),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
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
