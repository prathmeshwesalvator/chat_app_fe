import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/user_info_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';

@freezed
abstract class UserInfoModel with _$UserInfoModel {
  const factory UserInfoModel({
    @Default('') final String username,
    @Default('') final String email,
    @Default('') @JsonKey(name: 'full_name') final String fullName,
  }) = _UserInfoModel;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
}

extension UserInfoModelX on UserInfoModel {
  UserInfoEntities toDomain() =>
      UserInfoEntities(username: username, email: email, fullName: fullName);
}
