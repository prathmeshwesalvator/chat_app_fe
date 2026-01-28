// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContactModel _$ContactModelFromJson(Map<String, dynamic> json) =>
    _ContactModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      contactUserId: (json['contact_user_id'] as num?)?.toInt() ?? 0,
      contactUsername: json['contact_username'] as String? ?? '',
      contactEmail: json['contact_email'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );

Map<String, dynamic> _$ContactModelToJson(_ContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contact_user_id': instance.contactUserId,
      'contact_username': instance.contactUsername,
      'contact_email': instance.contactEmail,
      'created_at': instance.createdAt,
    };
