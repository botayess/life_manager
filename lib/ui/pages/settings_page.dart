import 'package:flutter/material.dart';
import '../../app/app_state.dart';
import '../../app/app_state_scope.dart';
import '../../l10n/strings.dart';
import '../widgets/section_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = StringsScope.of(context);
    final appState = AppStateScope.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.settings,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: s.theme,
            subtitle: 'Светлая / тёмная / системная (уже работает).',
            trailing: DropdownButton<ThemeMode>(
              value: appState.themeMode,
              onChanged: (v) {
                if (v != null) appState.setThemeMode(v);
              },
              items: [
                DropdownMenuItem(value: ThemeMode.system, child: Text(s.system)),
                DropdownMenuItem(value: ThemeMode.light, child: Text(s.light)),
                DropdownMenuItem(value: ThemeMode.dark, child: Text(s.dark)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: s.language,
            subtitle: 'RU / EN (уже работает).',
            trailing: DropdownButton<Locale>(
              value: appState.locale,
              onChanged: (v) {
                if (v != null) appState.setLocale(v);
              },
              items: [
                DropdownMenuItem(value: const Locale('ru'), child: Text(s.russian)),
                DropdownMenuItem(value: const Locale('en'), child: Text(s.english)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: s.accent,
            subtitle: 'Нейтральные оттенки + выбор акцента.',
            trailing: DropdownButton<AccentColorChoice>(
              value: appState.accent,
              onChanged: (v) {
                if (v != null) appState.setAccent(v);
              },
              items: const [
                DropdownMenuItem(value: AccentColorChoice.slate, child: Text('Slate')),
                DropdownMenuItem(value: AccentColorChoice.indigo, child: Text('Indigo')),
                DropdownMenuItem(value: AccentColorChoice.emerald, child: Text('Emerald')),
                DropdownMenuItem(value: AccentColorChoice.rose, child: Text('Rose')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionCard(
            title: 'Командная работа',
            subtitle:
                'Разделите экраны по участникам и делайте отдельные ветки + Pull Request. Каждый участник — минимум 1 meaningful commit.',
          ),
        ],
      ),
    );
  }
}
