import 'package:flutter/material.dart';

/// Time Tree color palette.
abstract final class TreeColors {
  static const background = Color(0xFF0A0C10);
  static const branchDefault = Color(0xFF1A1E28);
  static const branchActive = Color(0xFF2E4A6E);
  static const highlight = Color(0xFF4A7AB5);
  static const activation = Color(0xFFB8A44C);
  static const dormant = Color(0xFF52525A);
  static const nodePoint = Color(0xFF506882);

  static const textPrimary = Color(0xFFD0D4DC);
  static const textSecondary = Color(0xFF9EA2AA);
  static const error = Color(0xFFB54A4A);
  static const surface = Color(0xFF10131A);
}

/// EndStream application theme built on the Time Tree design language.
abstract final class EndStreamTheme {
  static ThemeData get data => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(
      primary: TreeColors.highlight,
      secondary: TreeColors.activation,
      surface: TreeColors.surface,
      error: TreeColors.error,
      onPrimary: TreeColors.textPrimary,
      onSecondary: TreeColors.background,
      onSurface: TreeColors.textPrimary,
      onError: TreeColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: TreeColors.background,
      foregroundColor: TreeColors.textPrimary,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 28,
        fontWeight: FontWeight.w300,
        color: TreeColors.textPrimary,
        letterSpacing: 1.2,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 22,
        fontWeight: FontWeight.w300,
        color: TreeColors.textPrimary,
        letterSpacing: 1.0,
      ),
      titleLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: TreeColors.textPrimary,
        letterSpacing: 0.8,
      ),
      titleMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: TreeColors.textPrimary,
        letterSpacing: 0.6,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: TreeColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: TreeColors.textSecondary,
      ),
      labelLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: TreeColors.textPrimary,
        letterSpacing: 1.0,
      ),
      labelSmall: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: TreeColors.textSecondary,
        letterSpacing: 0.8,
      ),
    ),
    dividerColor: TreeColors.branchDefault,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: TreeColors.branchDefault),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: TreeColors.highlight),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: TreeColors.error),
      ),
      hintStyle: TextStyle(fontFamily: 'monospace', color: TreeColors.dormant),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: TreeColors.branchActive,
        foregroundColor: TreeColors.textPrimary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: const TextStyle(fontFamily: 'monospace', letterSpacing: 1.0),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: TreeColors.textPrimary,
        side: const BorderSide(color: TreeColors.branchDefault),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: const TextStyle(fontFamily: 'monospace', letterSpacing: 1.0),
      ),
    ),
    cardTheme: const CardThemeData(
      color: TreeColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 0,
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: TreeColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  );
}
