import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData flexTheme() => FlexThemeData.dark(
        colors: FlexColor.schemesList[4].dark,
        fontFamily: GoogleFonts.roboto().fontFamily,
        surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
        blendLevel: 6,
      );
}
