import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF087BFF);
  static const illustrationBackground = Color(0xFFEAF2FF);
  static const selectedBackground = Color(0xFFEAF2FF);
  static const border = Color(0xFFDCE3EC);
  static const secondaryText = Color(0xFF697586);
}

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    );
    return ThemeData(
      colorScheme: colorScheme.copyWith(primary: AppColors.primary),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
