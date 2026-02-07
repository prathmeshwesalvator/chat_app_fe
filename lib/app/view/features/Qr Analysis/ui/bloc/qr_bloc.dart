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

    on<GetUserInfo>(
      (event, emit) async {
        emit(state.copyWith(userInfoStatus: Blocstatus.loading));

        final response = await qrUsecases.getInfo(event.body);

        response.fold((l) {
          emit(state.copyWith(
              userInfoStatus: Blocstatus.error, errorMessage: l.errorMessage));
        }, (r) {
          emit(state.copyWith(userInfoStatus: Blocstatus.success, userInfo: r));
        });
      },
    );

    on<AddContact>(
      (event, emit) async {
        emit(state.copyWith(addContactStatus: Blocstatus.loading));

        final response = await qrUsecases.addContact(body: event.body);

        response.fold((l) {
          emit(state.copyWith(
              addContactStatus: Blocstatus.error, errorMessage: l.toString()));
        }, (r) {
          emit(state.copyWith(addContactStatus: Blocstatus.success));
        });
      },
    );
  }
}
