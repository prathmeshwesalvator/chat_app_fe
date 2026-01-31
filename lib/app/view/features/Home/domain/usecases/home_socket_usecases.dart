import 'package:chat_app_fe/app/view/features/Home/domain/repositories/home_socket_repositories.dart';

abstract class HomeSocketUsecases {
  void connect();
  Future<Stream<dynamic>> messages();
  void sendMessage(
      {required int sender,
      required int receiver,
      required String message});
  void disconnect();
}

class HomeSocketUsecasesImpl implements HomeSocketUsecases {
  final HomeSocketRepositories homeSocketRepositories;

  HomeSocketUsecasesImpl({required this.homeSocketRepositories});

  @override
  void connect() {
    homeSocketRepositories.connect();
  }

  @override
  Future<Stream<dynamic>> messages() async {
    return await homeSocketRepositories.messages();
  }

  @override
  void sendMessage(
      {required int sender,
      required int receiver,
      required String message}) {
    final Map<String, dynamic> data = {
      'sender': sender,
      'receiver': receiver,
      'message': message
    };

    homeSocketRepositories.sendMessage(data);
  }

  @override
  void disconnect() {
    homeSocketRepositories.disconnect();
  }
}
