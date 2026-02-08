import 'package:chat_app_fe/app/view/features/Home/domain/entities/message_entities.dart';

abstract class HomeSocketRepositories {
  Future<void> connect({required String roomName});
  Stream<MessageEntities> messages();
  void sendMessage(Map<String, dynamic> data);
  void disconnect();
}
