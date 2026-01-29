import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/qr_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'qr_state.freezed.dart';

@freezed
abstract class QrState with _$QrState {
  const factory QrState({
    final QrEntities? qrData,
    final Blocstatus? qrStatus,
    @Default('') final String errorMessage,
  }) = _QrState;

}
