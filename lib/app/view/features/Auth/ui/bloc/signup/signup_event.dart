abstract class SignupEvent {}

class SignUpSubmit extends SignupEvent {
  final String username;
  final String password;
  final String email;

  SignUpSubmit(
      {required this.username, required this.password, required this.email});
}

class SendOtp extends SignupEvent {
  final String email;

  SendOtp({required this.email});
}

class VerifyOtp extends SignupEvent {
  final String email;
  final String otp;

  VerifyOtp({required this.email, required this.otp});
}
