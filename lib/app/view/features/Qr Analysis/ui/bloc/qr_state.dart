import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/qr_entities.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/user_info_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'qr_state.freezed.dart';

@freezed
abstract class QrState with _$QrState {
  const factory QrState({
    final QrEntities? qrData,
    final Blocstatus? qrStatus,
    final Blocstatus? userInfoStatus,
    final UserInfoEntities? userInfo,
    final Blocstatus? addContactStatus,
    @Default('') final String errorMessage,
  }) = _QrState;

}
