// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QrModel _$QrModelFromJson(Map<String, dynamic> json) => _QrModel(
  message: json['message'] as String? ?? '',
  contactHash: json['contactHash'] as String? ?? '',
  expiresInMinutes: json['expiresInMinutes'] as String? ?? '',
  createdAt: json['createdAt'] as String? ?? '',
);

Map<String, dynamic> _$QrModelToJson(_QrModel instance) => <String, dynamic>{
  'message': instance.message,
  'contactHash': instance.contactHash,
  'expiresInMinutes': instance.expiresInMinutes,
  'createdAt': instance.createdAt,
};
