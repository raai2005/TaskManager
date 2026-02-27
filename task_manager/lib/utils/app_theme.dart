import 'package:flutter/material.dart';

/// App-wide colour palette and text styles.
class AppTheme {
  AppTheme._();

  // ── Primary palette ──────────────────────────────────
  static const Color primaryColor = Color(
    0xFF5A47FF,
  ); // Indigo (from animation)
  static const Color primaryLight = Color(0xFF7B6BFF); // Soft indigo
  static const Color primaryDark = Color(0xFF4838CC); // Deep indigo

  // ── Surface colours ──────────────────────────────────
  static const Color scaffoldBg = Color(0xFFF4F5FA);     // Cool-tinted grey
  static const Color cardBg = Colors.white;
  static const Color surfaceLight = Color(0xFFEEF0F7);

  // ── Status colours ───────────────────────────────────
  static const Color completedColor = Color(0xFF00BFA5); // Cool mint
  static const Color pendingColor = Color(0xFFFF7B54);   // Soft coral

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: primaryColor,
      scaffoldBackgroundColor: scaffoldBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF2D3436),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F6F8),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        selectedColor: primaryColor,
        backgroundColor: Colors.grey.shade100,
        labelStyle: const TextStyle(fontSize: 14),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
