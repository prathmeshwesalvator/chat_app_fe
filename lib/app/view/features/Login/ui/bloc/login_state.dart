import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState{
  const factory LoginState({
    Blocstatus? loginStatus,
    @Default('') String username,
    @Default('') String password,
    @Default('') String errorMessage,
    @Default('') String successMessage,

  }) = _LoginState;
}
