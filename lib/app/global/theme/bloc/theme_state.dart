import 'package:flutter/material.dart';

class AppGlobalState {
  final ThemeMode appTheme;
  final bool hapticFeedback;

  AppGlobalState({required this.appTheme, required this.hapticFeedback});

  factory AppGlobalState.initial() =>
      AppGlobalState(appTheme: ThemeMode.light, hapticFeedback: false);

  AppGlobalState copyWith({ThemeMode? appTheme, bool? hapticFeedback}) {
    return AppGlobalState(
        appTheme: appTheme ?? this.appTheme,
        hapticFeedback: hapticFeedback ?? this.hapticFeedback);
  }
}
