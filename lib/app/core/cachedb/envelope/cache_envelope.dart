class CacheEnvelope<T> {
  final int version;
  final DateTime createdAt;
  final DateTime expiresAt;
  final T data;

  CacheEnvelope({
    required this.version,
    required this.createdAt,
    required this.expiresAt,
    required this.data,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
