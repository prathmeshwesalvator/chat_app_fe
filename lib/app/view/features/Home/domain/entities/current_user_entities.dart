class CurrentUserEntities {
  final String message;
  final String? userId;
  final String username;
  final String email;
  final String dateJoined;

  CurrentUserEntities({
    required this.message,
    this.userId,
    required this.username,
    required this.email,
    required this.dateJoined,
  });
}
