import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/usecases/signup/signup_usecase.dart';
import 'package:chat_app_fe/app/view/features/Auth/ui/bloc/signup/signup_event.dart';
import 'package:chat_app_fe/app/view/features/Auth/ui/bloc/signup/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUsecases signupUsecase;

  SignupBloc({required this.signupUsecase}) : super(const SignupState()) {
    on<SendOtp>(
      (event, emit) async {
        emit(state.copyWith(sendOtpStatus: Blocstatus.loading));

        final response = await signupUsecase.sendOtp(email: event.email);

        response.fold((l) {
          emit(state.copyWith(
              errorMessage: l.toString(), sendOtpStatus: Blocstatus.error));
        }, (r) {
          emit(state.copyWith(
              successMessage: r.message, sendOtpStatus: Blocstatus.success));
        });
      },
    );

    on<VerifyOtp>(
      (event, emit) async {
        emit(state.copyWith(verifyOtpStatus: Blocstatus.loading));

        final response =
            await signupUsecase.verifyOtp(otp: event.otp, email: event.email);

        response.fold((l) {
          emit(state.copyWith(
              verifyOtpStatus: Blocstatus.error, errorMessage: l.toString()));
        }, (r) {
          emit(state.copyWith(
              verifyOtpStatus: Blocstatus.success, successMessage: r.message));
        });
      },
    );

    on<SignUpSubmit>(
      (event, emit) async {
        emit(state.copyWith(signupStatus: Blocstatus.loading));

        final response = await signupUsecase.signupSubmit(
            username: event.username,
            email: event.email,
            password: event.password);

        response.fold((l) {
          emit(state.copyWith(
              errorMessage: l.toString(), signupStatus: Blocstatus.error));
        }, (r) {
          emit(state.copyWith(
              successMessage: r.message, signupStatus: Blocstatus.success));
        });
      },
    );
  }
}
