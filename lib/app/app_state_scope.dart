import 'package:flutter/material.dart';
import 'app_state.dart';

class AppStateScope extends InheritedWidget {
  final AppState state;

  const AppStateScope({
    super.key,
    required this.state,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in context');
    return scope!.state;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) => oldWidget.state != state;
}
