import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF0D47A1); // Deep Blue
  static const Color accentBlue = Color(0xFF1976D2);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black87;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: const TextStyle(color: textColor),
        bodyMedium: const TextStyle(color: textColor),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        secondary: accentBlue,
        surface: backgroundColor,
      ),
    );
  }
}
