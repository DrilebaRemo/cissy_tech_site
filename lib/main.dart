import 'package:flutter/material.dart';
import 'features/home/home_page.dart';
import 'core/theme/app_colors.dart';

void main() {
  runApp(const CissyTechApp());
}

class CissyTechApp extends StatelessWidget {
  const CissyTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cissy Technologies Limited',
      debugShowCheckedModeBanner: false,
      // We set the global theme color to your Brand Blue
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
        // This ensures the font looks good by default
        fontFamily: 'Inter', 
      ),
      // This tells Flutter: "Start the app here"
      home: const HomePage(),
    );
  }
}