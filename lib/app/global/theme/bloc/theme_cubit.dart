import 'package:chat_app_fe/app/global/theme/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void changeTheme() {
    emit(state.appTheme == ThemeMode.light
        ? state.copyWith(appTheme: ThemeMode.dark)
        : state.copyWith(appTheme: ThemeMode.light));
  }
}
