class SignupUserEntity {
  final int userId;
  final String username;
  final String email;
  final String dateJoined;
  final String accessToken;
  final String refreshToken;
  final String message;

  const SignupUserEntity({
    required this.userId,
    required this.username,
    required this.email,
    required this.dateJoined,
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });
}
