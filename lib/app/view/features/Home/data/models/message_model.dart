import 'package:chat_app_fe/app/view/features/Home/domain/entities/message_entities.dart';

class MessageModel {
  final String type;
  final String message;
  final int? sender;
  final int? receiver;

  MessageModel(
      {required this.type, required this.message, this.sender, this.receiver});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      type: json['type']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      sender: json['sender'] is int ? json['sender'] : null,
      receiver: json['receiver'] is int ? json['receiver'] : null,
    );
  }

  MessageEntities toDomain() => MessageEntities(
      type: type, message: message, receiver: receiver, sender: sender);
}
