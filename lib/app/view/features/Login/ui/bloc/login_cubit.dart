import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Login/domain/usecases/login_usecases.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUsecases}) : super(const LoginState());

  final LoginUsecases loginUsecases;

  void onLoginSUbmit(final String username, final String password) async {
    emit(state.copyWith(loginStatus: Blocstatus.loading));

    final response = await loginUsecases.loginUser(username, password);

    response.fold(
      (l) {
        emit(
          state.copyWith(
            loginStatus: Blocstatus.error,
            errorMessage: l.errorMessage.toString(),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            loginStatus: Blocstatus.success,
            successMessage: r.toString(),
          ),
        );
      },
    );
  }
}
