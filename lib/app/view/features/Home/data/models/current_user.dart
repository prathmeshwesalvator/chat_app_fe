import 'package:chat_app_fe/app/global/converters/int_to_string_converter.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/entities/current_user_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'current_user.g.dart';
part 'current_user.freezed.dart';

@freezed
abstract class CurrentUser with _$CurrentUser {
  const factory CurrentUser({
    @Default('') String message,
    @IntToStringConverter() String? userId,
    @Default('') String username,
    @Default('') String email,
    @Default('') String dateJoined,
  }) = _CurrentUser;

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);
}

extension CurrentUserX on CurrentUser {
  CurrentUserEntities toDomain() => CurrentUserEntities(
      message: message,
      username: username,
      email: email,
      dateJoined: dateJoined,
      userId: userId);
}
