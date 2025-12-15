import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/theme_controller.dart'; 

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
        return MaterialApp.router(
          title: 'Cissy Technologies Limited',
          debugShowCheckedModeBanner: false,

          // 1. Apply Inter Font to Light Theme
          theme: AppTheme.lightTheme.copyWith(
            textTheme: GoogleFonts.interTextTheme(AppTheme.lightTheme.textTheme),
          ),

          // 2. Apply Inter Font to Dark Theme
          darkTheme: AppTheme.darkTheme.copyWith(
            textTheme: GoogleFonts.interTextTheme(AppTheme.darkTheme.textTheme),
          ),
          
          // Use the current mode from the controller
          themeMode: currentMode, 
          
          routerConfig: appRouter,
        );
      },
    );
  }
}