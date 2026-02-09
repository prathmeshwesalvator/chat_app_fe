class Success {
  final String message;

  Success({required this.message});

  factory Success.fromJson(Map<String, dynamic> json) =>
      Success(message: json['message']);
}
