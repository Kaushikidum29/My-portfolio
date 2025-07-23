import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xff343D68);
  static const Color secondaryColor = Color(0xFFF63B66);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF1A1A2E);
  static const Color textColor = Color(0xFF525F7F);
  static const Color lightTextColor = Color(0xFF8898AA);
  static const Color darkTextColor = Color(0xFFD1D9E6);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      background: backgroundColor,
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: textColor,
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: textColor,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: lightTextColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      background: darkBackground,
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: darkTextColor,
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: darkTextColor,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: darkTextColor,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: darkTextColor,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: lightTextColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
