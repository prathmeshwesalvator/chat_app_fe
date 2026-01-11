// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) => _CurrentUser(
  message: json['message'] as String? ?? '',
  userId: const IntToStringConverter().fromJson(
    (json['userId'] as num?)?.toInt(),
  ),
  username: json['username'] as String? ?? '',
  email: json['email'] as String? ?? '',
  dateJoined: json['dateJoined'] as String? ?? '',
);

Map<String, dynamic> _$CurrentUserToJson(_CurrentUser instance) =>
    <String, dynamic>{
      'message': instance.message,
      'userId': const IntToStringConverter().toJson(instance.userId),
      'username': instance.username,
      'email': instance.email,
      'dateJoined': instance.dateJoined,
    };
