import 'package:chat_app_fe/app/view/features/Login/domain/entities/login_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_model.freezed.dart';
part 'login_model.g.dart';

@freezed
abstract class LoginModel with _$LoginModel {
  const factory LoginModel({
    @Default('') String message,
    @Default('') String accessToken,
    @Default('') String refreshToken,
  }) = _LoginModel;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}

extension LoginModelX on LoginModel {
  LoginEntities toDomain() => LoginEntities(
    message: message,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
}
