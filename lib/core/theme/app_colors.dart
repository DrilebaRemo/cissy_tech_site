import 'package:flutter/material.dart';

class AppColors {
  // --- BRAND COLORS ---
  static const Color primary = Color(0xFF00A3FF);
  static const Color accent = Color(0xFFFF9900);
  
  // --- FIX: RESTORE MISSING VARIABLES (The Aliases) ---
  // These map the old names to the new Light Mode colors so your app stops crashing.
  static const Color background = lightBackground;
  static const Color border = lightBorder;
  static const Color textMain = lightTextMain;
  static const Color textBody = lightTextBody;
  static const Color primaryLight = Color(0xFFE0F5FF); // Restored this missing color

  // --- LIGHT MODE PALETTE ---
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF9FAFB); 
  static const Color lightTextMain = Color(0xFF111827); 
  static const Color lightTextBody = Color(0xFF4B5563); 
  static const Color lightBorder = Color(0xFFE5E7EB);

  // --- DARK MODE PALETTE ---
  static const Color darkBackground = Color(0xFF0F1016); 
  static const Color darkSurface = Color(0xFF1A1D26);    
  static const Color darkTextMain = Color(0xFFFFFFFF);   
  static const Color darkTextBody = Color(0xFF9CA3AF);   
  static const Color darkBorder = Color(0xFF2D303E);     
}