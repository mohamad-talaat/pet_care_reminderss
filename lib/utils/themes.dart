import 'package:flutter/material.dart';

ThemeData themeEnglish = ThemeData(
  primaryColor: const Color(0xFF6C63FF),
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  fontFamily: 'Poppins',
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFF6C63FF),
    secondary: const Color(0xFFFF6584),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF6C63FF),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6C63FF),
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    foregroundColor: Color(0xFF6C63FF),
    elevation: 0,
    centerTitle: true,
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 2,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
);
 