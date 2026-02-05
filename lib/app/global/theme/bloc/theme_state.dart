import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode appTheme;

  ThemeState({required this.appTheme});

  factory ThemeState.initial() => ThemeState(appTheme: ThemeMode.light);

  ThemeState copyWith({ThemeMode? appTheme}) {
    return ThemeState(appTheme: appTheme ?? this.appTheme);
  }
}
