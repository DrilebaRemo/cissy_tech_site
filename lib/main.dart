import 'package:flutter/material.dart';
import 'features/home/home_page.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart'; // Import the controller

void main() {
  runApp(const CissyTechApp());
}

class CissyTechApp extends StatelessWidget {
  const CissyTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the ThemeController
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Cissy Technologies Limited',
          debugShowCheckedModeBanner: false,
          
          // Define both themes
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          
          // Use the current mode from the controller
          themeMode: currentMode, 
          
          home: const HomePage(),
        );
      },
    );
  }
}