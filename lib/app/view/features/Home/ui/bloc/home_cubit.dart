import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/usecases/home_socket_usecases.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/usecases/home_usecases.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUsecases homeUsecases;
  final HomeSocketUsecases homeSocketUsecases;

  HomeCubit({required this.homeUsecases, required this.homeSocketUsecases})
      : super(const HomeState());
  void loadUserProfile() async {
    emit(state.copyWith(profileStatus: Blocstatus.loading));

    final response = await homeUsecases.fetchUserProfile();

    response.fold(
      (l) {
        emit(
          state.copyWith(
            profileStatus: Blocstatus.error,
            errorMessage: l.errorMessage,
          ),
        );
      },
      (r) {

        emit(
          state.copyWith(
            profileStatus: Blocstatus.success,
            username: r.username,
            userId: r.userId,
            email: r.email,
            dateJoined: r.dateJoined,
            message: r.message,
          ),
        );
      },
    );
  }

  void logOutUser() async {
    emit(state.copyWith(logOutStatus: Blocstatus.loading));

    final response = await homeUsecases.logOutUser();

    response.fold(
      (l) {
        emit(state.copyWith(logOutStatus: Blocstatus.error));
      },
      (r) {
        emit(state.copyWith(logOutStatus: Blocstatus.success, message: r));
      },
    );
  }

  void connectSockets() {
    homeSocketUsecases.connect();
  }

  Future<Stream<dynamic>> messages() async {
    return await homeSocketUsecases.messages();
  }

  void sendMessage(
      {required int receiver, required String message, required int sender}) {
    homeSocketUsecases.sendMessage(
        sender: sender, receiver: receiver, message: message);
  }

  void disconnectSockets() {
    homeSocketUsecases.disconnect();
  }
}
