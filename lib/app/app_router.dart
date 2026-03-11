import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/shell/app_shell.dart';
import '../ui/pages/dashboard_page.dart';
import '../ui/pages/finance_page.dart';
import '../ui/pages/habits_page.dart';
import '../ui/pages/planner_page.dart';
import '../ui/pages/profile_page.dart';
import '../ui/pages/settings_page.dart';
import 'app_state.dart';

GoRouter buildRouter(AppState state) {
  return GoRouter(
    initialLocation: '/dashboard',
    refreshListenable: state,
    routes: [
      ShellRoute(
        builder: (context, routerState, child) {
          return AppShell(
            appState: state,
            location: routerState.uri.toString(),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DashboardPage()),
          ),
          GoRoute(
            path: '/habits',
            name: 'habits',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HabitsPage()),
          ),
          GoRoute(
            path: '/finance',
            name: 'finance',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: FinancePage()),
          ),
          GoRoute(
            path: '/planner',
            name: 'planner',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: PlannerPage()),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfilePage()),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SettingsPage()),
          ),
        ],
      ),
    ],
  );
}
