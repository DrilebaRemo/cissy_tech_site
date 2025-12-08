import 'package:flutter/material.dart';

// A global controller to switch themes
class ThemeController extends ValueNotifier<ThemeMode> {
  // Singleton pattern (so we can access it from anywhere easily)
  static final ThemeController instance = ThemeController._();

  ThemeController._() : super(ThemeMode.light); // Start with Light Mode

  void toggleTheme() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}