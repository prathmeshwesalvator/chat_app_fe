import 'package:chat_app_fe/app/view/features/Home/domain/entities/message_entities.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/repositories/home_socket_repositories.dart';

abstract class HomeSocketUsecases {
  Future<void> connect({required String roomName});
  Stream<MessageEntities> messages();
  void sendMessage({
    required int sender,
    required int receiver,
    required String message,
  });
  void disconnect();
}

class HomeSocketUsecasesImpl implements HomeSocketUsecases {
  final HomeSocketRepositories homeSocketRepositories;

  HomeSocketUsecasesImpl({required this.homeSocketRepositories});

  @override
  Future<void> connect({required String roomName}) => homeSocketRepositories.connect(roomName: roomName);

  @override
  Stream<MessageEntities> messages() => homeSocketRepositories.messages();

  @override
  void sendMessage({
    required int sender,
    required int receiver,
    required String message,
  }) {
    homeSocketRepositories.sendMessage({
      'sender': sender,
      'receiver': receiver,
      'message': message,
    });
  }

  @override
  void disconnect() => homeSocketRepositories.disconnect();
}
