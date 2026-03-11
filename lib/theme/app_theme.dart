import 'package:flutter/material.dart';
import '../app/app_state.dart';

class AppTheme {
  static ColorScheme _scheme(Brightness b, AccentColorChoice accent) {
    final base = switch (accent) {
      AccentColorChoice.slate => const Color(0xFF334155),
      AccentColorChoice.indigo => const Color(0xFF4F46E5),
      AccentColorChoice.emerald => const Color(0xFF059669),
      AccentColorChoice.rose => const Color(0xFFE11D48),
    };
    return ColorScheme.fromSeed(seedColor: base, brightness: b);
  }

  static ThemeData light(AccentColorChoice accent) {
    final scheme = _scheme(Brightness.light, accent);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFFF7F7F8),
      cardTheme: const CardThemeData(
  elevation: 0,
  margin: EdgeInsets.zero,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
  ),
),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
      ),
    );
  }

  static ThemeData dark(AccentColorChoice accent) {
    final scheme = _scheme(Brightness.dark, accent);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF0B0F16),
      cardTheme: const CardThemeData(
  elevation: 0,
  margin: EdgeInsets.zero,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
  ),
),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF111827),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
      ),
    );
  }
}
