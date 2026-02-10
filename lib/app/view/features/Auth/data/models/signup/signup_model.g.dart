// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignupUserModel _$SignupUserModelFromJson(Map<String, dynamic> json) =>
    _SignupUserModel(
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      dateJoined: json['dateJoined'] as String? ?? '',
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$SignupUserModelToJson(_SignupUserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'dateJoined': instance.dateJoined,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'message': instance.message,
    };
