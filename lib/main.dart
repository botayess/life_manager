import 'package:flutter/material.dart';
import 'app/app_router.dart';
import 'app/app_state.dart';

void main() {
  final appState = AppState();
  final router = buildRouter(appState);

  runApp(MyApp(
    appState: appState,
    router: router,
  ));
}

class MyApp extends StatelessWidget {
  final AppState appState;
  final GoRouter router;

  const MyApp({
    super.key,
    required this.appState,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: appState.themeMode,
          locale: appState.locale,
          routerConfig: router,
        );
      },
    );
  }
}
