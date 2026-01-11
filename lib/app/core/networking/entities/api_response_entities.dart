class ApiResponseEntities<T> {
  final int statusCode;
  final String message;
  final T data;

  ApiResponseEntities({
    required this.statusCode,
    required this.message,
    required this.data,
  });
}
