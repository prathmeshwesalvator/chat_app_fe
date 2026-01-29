import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/qr_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'qr_model.freezed.dart';
part 'qr_model.g.dart';

@freezed
abstract class QrModel with _$QrModel {
  const factory QrModel({
    @Default('') String message,
    @Default('') String contactHash,
    @Default('') String expiresInMinutes,
    @Default('') String createdAt,
  }) = _QrModel;

  factory QrModel.fromJson(Map<String, dynamic> json) =>
      _$QrModelFromJson(json);
}

extension QrModelX on QrModel {
  QrEntities toDomain() => QrEntities(
    message: message,
    contactHash: contactHash,
    expiresInMinutes: expiresInMinutes,
    createdAt: createdAt,
  );
}
