import 'package:flutter/material.dart';

enum AccentColorChoice { slate, indigo, emerald, rose }

class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('ru');
  AccentColorChoice _accent = AccentColorChoice.slate;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  AccentColorChoice get accent => _accent;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void setAccent(AccentColorChoice value) {
    _accent = value;
    notifyListeners();
  }
}
