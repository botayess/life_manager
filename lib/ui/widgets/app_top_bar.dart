import 'package:flutter/material.dart';

import '../../app/app_state.dart';
import '../../l10n/strings.dart';

class AppTopBar extends StatelessWidget {
  final AppState appState;
  const AppTopBar({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final s = StringsScope.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              s.appName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          IconButton(
            tooltip: 'Theme',
            onPressed: () {
              final next = switch (appState.themeMode) {
                ThemeMode.system => ThemeMode.light,
                ThemeMode.light => ThemeMode.dark,
                ThemeMode.dark => ThemeMode.system,
              };
              appState.setThemeMode(next);
            },
            icon: Icon(
              switch (appState.themeMode) {
                ThemeMode.system => Icons.brightness_auto_rounded,
                ThemeMode.light => Icons.light_mode_rounded,
                ThemeMode.dark => Icons.dark_mode_rounded,
              },
            ),
          ),
          const SizedBox(width: 6),
          PopupMenuButton<Locale>(
            tooltip: s.language,
            onSelected: appState.setLocale,
            itemBuilder: (context) => const [
              PopupMenuItem(value: Locale('ru'), child: Text('Русский')),
              PopupMenuItem(value: Locale('en'), child: Text('English')),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.language_rounded),
                  const SizedBox(width: 8),
                  Text(appState.locale.languageCode.toUpperCase()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
