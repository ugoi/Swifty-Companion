import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swifty_companion/theme/color_styles.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.grey.shade400,
        primary: Colors.grey.shade300,
        secondary: Colors.grey.shade200));

ThemeData darkMode = ThemeData(
    // searchBarTheme: SearchBarThemeData(),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(DarkColorStyles.background),
    textTheme: GoogleFonts.poppinsTextTheme(const TextTheme()),
    searchBarTheme: SearchBarThemeData(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Color(DarkColorStyles.border))),
      ),
    ),
    colorScheme: ColorScheme.dark(
      surface: Color(DarkColorStyles.background),
      primary: Color(DarkColorStyles.highlight),
      secondary: Color(DarkColorStyles.primary),
      surfaceContainer: Color(DarkColorStyles.card),
      surfaceContainerLow: Color(DarkColorStyles.cardSecondary),
      tertiary: Color(DarkColorStyles.success),
      outline: Color(DarkColorStyles.border),
    ));
