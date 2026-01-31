import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/usecases/qr_usecases.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  final QrUsecases qrUsecases;

  QrBloc({required this.qrUsecases}) : super(const QrState()) {
    on<GenerateHash>((event, emit) async {
      emit(state.copyWith(qrStatus: Blocstatus.loading));

      final response = await qrUsecases.generateHash();

      response.fold(
        (l) {
          emit(
            state.copyWith(
              qrStatus: Blocstatus.error,
              errorMessage: l.errorMessage,
            ),
          );
        },
        (r) {
          emit(state.copyWith(qrStatus: Blocstatus.success, qrData: r));
        },
      );
    });
  }
}
