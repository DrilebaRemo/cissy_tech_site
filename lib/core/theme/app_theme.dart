import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // 1. LIGHT THEME CONFIG
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.primary,
      
      // Card Styles
      cardColor: AppColors.lightSurface,
      dividerColor: AppColors.lightBorder,

      // Text Styles
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.lightTextMain), // Headlines
        bodyLarge: TextStyle(color: AppColors.lightTextBody),    // Paragraphs
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.lightTextMain),
    );
  }

  // 2. DARK THEME CONFIG
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.primary,

      // Card Styles
      cardColor: AppColors.darkSurface,
      dividerColor: AppColors.darkBorder,

      // Text Styles
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.darkTextMain),
        bodyLarge: TextStyle(color: AppColors.darkTextBody),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.darkTextMain),
    );
  }
}