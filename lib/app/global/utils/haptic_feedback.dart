import 'package:chat_app_fe/app/global/theme/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension HapticX on BuildContext {
  bool get _isHapticOn => read<AppGlobalCubit>().state.hapticFeedback;

  void hapticLight() {
    if (_isHapticOn) HapticFeedback.heavyImpact();
  }

  void hapticMedium() {
    if (_isHapticOn) HapticFeedback.mediumImpact();
  }

  void hapticHeavy() {
    if (_isHapticOn) HapticFeedback.heavyImpact();
  }

  void hapticSelection() {
    if (_isHapticOn) HapticFeedback.selectionClick();
  }

  void hapticVibrate() {
    if (_isHapticOn) HapticFeedback.vibrate();
  }
}
