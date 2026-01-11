import 'package:chat_app_fe/app/global/converters/int_to_string_converter.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default('') String message,
    @IntToStringConverter() String? userId,
    @Default('') String username,
    @Default('') String email,
    @Default('') String dateJoined,
    Blocstatus? profileStatus,
    @Default('') String errorMessage,
  }) = _HomeState;
}
