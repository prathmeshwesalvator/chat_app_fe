import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'signup_state.freezed.dart';


@freezed
abstract class SignupState with _$SignupState {
  const factory SignupState({
    Blocstatus? signupStatus,
    Blocstatus? sendOtpStatus,
    Blocstatus? verifyOtpStatus,
    @Default('') String errorMessage,
    @Default('') String successMessage,
  }) = _SignUpState;
}
