import 'package:flutter/material.dart';

class Strings {
  final String appName;
  final String dashboard;
  final String habits;
  final String finance;
  final String planner;
  final String profile;
  final String settings;

  final String today;
  final String quickActions;
  final String addHabit;
  final String addIncome;
  final String addExpense;
  final String addTask;

  final String uiOnlyHint;

  final String theme;
  final String language;
  final String accent;
  final String system;
  final String light;
  final String dark;
  final String russian;
  final String english;

  const Strings({
    required this.appName,
    required this.dashboard,
    required this.habits,
    required this.finance,
    required this.planner,
    required this.profile,
    required this.settings,
    required this.today,
    required this.quickActions,
    required this.addHabit,
    required this.addIncome,
    required this.addExpense,
    required this.addTask,
    required this.uiOnlyHint,
    required this.theme,
    required this.language,
    required this.accent,
    required this.system,
    required this.light,
    required this.dark,
    required this.russian,
    required this.english,
  });

  static Strings ofLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return const Strings(
          appName: 'Life Manager',
          dashboard: 'Dashboard',
          habits: 'Habits',
          finance: 'Finance',
          planner: 'Planner',
          profile: 'Profile',
          settings: 'Settings',
          today: 'Today',
          quickActions: 'Quick actions',
          addHabit: 'Add habit',
          addIncome: 'Add income',
          addExpense: 'Add expense',
          addTask: 'Add task',
          uiOnlyHint: 'UI only (no real saving yet).',
          theme: 'Theme',
          language: 'Language',
          accent: 'Accent',
          system: 'System',
          light: 'Light',
          dark: 'Dark',
          russian: 'Russian',
          english: 'English',
        );
      case 'ru':
      default:
        return const Strings(
          appName: 'Life Manager',
          dashboard: 'Главная',
          habits: 'Привычки',
          finance: 'Финансы',
          planner: 'Планировщик',
          profile: 'Профиль',
          settings: 'Настройки',
          today: 'Сегодня',
          quickActions: 'Быстрые действия',
          addHabit: 'Добавить привычку',
          addIncome: 'Добавить доход',
          addExpense: 'Добавить расход',
          addTask: 'Добавить задачу',
          uiOnlyHint: 'Пока только UI (без реального сохранения).',
          theme: 'Тема',
          language: 'Язык',
          accent: 'Акцент',
          system: 'Системная',
          light: 'Светлая',
          dark: 'Тёмная',
          russian: 'Русский',
          english: 'English',
        );
    }
  }
}

class StringsScope extends InheritedWidget {
  final Strings strings;
  const StringsScope({
    super.key,
    required this.strings,
    required super.child,
  });

  static Strings of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<StringsScope>();
    return scope?.strings ?? Strings.ofLocale(const Locale('ru'));
  }

  @override
  bool updateShouldNotify(StringsScope oldWidget) => oldWidget.strings != strings;
}
