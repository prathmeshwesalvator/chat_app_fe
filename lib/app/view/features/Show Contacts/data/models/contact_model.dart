import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/entities/contact_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'contact_model.freezed.dart';
part 'contact_model.g.dart';

@freezed
abstract class ContactModel with _$ContactModel {
  const factory ContactModel({
    @JsonKey(name: 'id') @Default(0) int id,
    @JsonKey(name: 'contact_user_id') @Default(0) int contactUserId,
    @JsonKey(name: 'contact_username') @Default('') String contactUsername,
    @JsonKey(name: 'contact_email') @Default('') String contactEmail,
    @JsonKey(name: 'created_at') @Default('') String createdAt,
  }) = _ContactModel;

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);
}

extension ContactModelX on ContactModel {
  ContactEntities toDomain() => ContactEntities(
    id: id,
    contactUserId: contactUserId,
    contactUsername: contactUsername,
    contactEmail: contactEmail,
    createdAt: createdAt,
  );
}
