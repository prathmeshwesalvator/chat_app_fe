class QrEntities {
  final String message;
  final String contactHash;
  final String expiresInMinutes;
  final String createdAt;

  QrEntities({
    required this.message,
    required this.contactHash,
    required this.expiresInMinutes,
    required this.createdAt,
  });
}
