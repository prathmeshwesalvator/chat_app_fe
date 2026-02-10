import 'package:chat_app_fe/app/view/features/Auth/domain/entities/signup_user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'signup_model.freezed.dart';
part 'signup_model.g.dart';

@freezed
abstract class SignupModel with _$SignupModel {
  const factory SignupModel({
    @Default(0) int userId,
    @Default('') String username,
    @Default('') String email,
    @Default('') String dateJoined,
    @Default('') String accessToken,
    @Default('') String refreshToken,
    @Default('') String message,
  }) = _SignupUserModel;

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);
}

extension SignUpModelX on SignupModel {
  SignupUserEntity toDomain() => SignupUserEntity(
      userId: userId,
      username: username,
      email: email,
      dateJoined: dateJoined,
      accessToken: accessToken,
      refreshToken: refreshToken,
      message: message);
}
