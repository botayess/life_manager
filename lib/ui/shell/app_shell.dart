import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_state.dart';
import '../../l10n/strings.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/section_card.dart';

class AppShell extends StatelessWidget {
  final AppState appState;
  final String location;
  final Widget child;

  const AppShell({
    super.key,
    required this.appState,
    required this.location,
    required this.child,
  });

  int _indexFromLocation(String loc) {
    if (loc.startsWith('/habits')) return 1;
    if (loc.startsWith('/finance')) return 2;
    if (loc.startsWith('/planner')) return 3;
    if (loc.startsWith('/profile')) return 4;
    if (loc.startsWith('/settings')) return 5;
    return 0;
  }

  void _goByIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/habits');
        break;
      case 2:
        context.go('/finance');
        break;
      case 3:
        context.go('/planner');
        break;
      case 4:
        context.go('/profile');
        break;
      case 5:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = StringsScope.of(context);
    final index = _indexFromLocation(location);
    final wide = MediaQuery.of(context).size.width >= 980;

    final destinations = <NavigationDestination>[
      NavigationDestination(
        icon: const Icon(Icons.grid_view_rounded),
        label: s.dashboard,
      ),
      NavigationDestination(
        icon: const Icon(Icons.repeat_rounded),
        label: s.habits,
      ),
      NavigationDestination(
        icon: const Icon(Icons.account_balance_wallet_rounded),
        label: s.finance,
      ),
      NavigationDestination(
        icon: const Icon(Icons.event_note_rounded),
        label: s.planner,
      ),
      NavigationDestination(
        icon: const Icon(Icons.person_rounded),
        label: s.profile,
      ),
      NavigationDestination(
        icon: const Icon(Icons.settings_rounded),
        label: s.settings,
      ),
    ];

    return Scaffold(
      body: Row(
        children: [
          if (wide)
            NavigationRail(
              selectedIndex: index,
              onDestinationSelected: (i) => _goByIndex(context, i),
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Icon(Icons.bolt_rounded, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      s.appName,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              destinations: [
                for (final d in destinations)
                  NavigationRailDestination(
                    icon: d.icon,
                    label: Text(d.label),
                  ),
              ],
            ),
          Expanded(
            child: SafeArea(
              child: Column(
                children: [
                  AppTopBar(appState: appState),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                    child: SectionCard(
                      title: s.uiOnlyHint,
                      subtitle:
                          'Функционал будет добавляться по неделям (по коммитам).',
                      trailing: FilledButton.tonal(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Это демо UI.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text('Ок'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (i) => _goByIndex(context, i),
              destinations: destinations,
            ),
    );
  }
}
