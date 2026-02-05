class MessageEntities {
  final String type;
  final String message;
  final int? sender;
  final int? receiver;
  final String? timestamp;

  MessageEntities({
    required this.type,
    required this.message,
    this.sender,
    this.receiver,
    this.timestamp,
  });

  factory MessageEntities.fromJson(Map<String, dynamic> json) {
    return MessageEntities(
      type: json['type'],
      message: json['message'],
      sender: json['sender'],
      receiver: json['receiver'],
    );
  }
}
