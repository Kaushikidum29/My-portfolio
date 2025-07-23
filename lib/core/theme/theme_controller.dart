import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_theme.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  ThemeData get theme => isDarkMode.value ? _darkTheme : AppTheme.lightTheme;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(theme);
  }

  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppTheme.primaryColor,
    scaffoldBackgroundColor: AppTheme.darkBackground,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppTheme.primaryColor,
      secondary: AppTheme.secondaryColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),
  );
}
