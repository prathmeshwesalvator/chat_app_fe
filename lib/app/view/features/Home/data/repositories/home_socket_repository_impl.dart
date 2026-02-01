import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/core/networking/api_contsants.dart';
import 'package:chat_app_fe/app/core/networking/websockets/websocket_service.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/repositories/home_socket_repositories.dart';

class HomeSocketRepositoryImpl implements HomeSocketRepositories {
  final WebsocketService websocketService;
  final Localstorage localstorage;

  HomeSocketRepositoryImpl(
      {required this.websocketService, required this.localstorage});

  @override
  void connect() async {
    websocketService.connect(
        url: Uri.parse(ApiConstants.webSocketUrl).replace(
            queryParameters: {'token': await localstorage.getToken()}));
  }

  @override
  void sendMessage(Map<String, dynamic> data) {
    websocketService.send(data);
  }

  @override
  Future<Stream<dynamic>> messages() async {
    return await websocketService.listen;
  }

  @override
  void disconnect() {
    websocketService.disconnect();
  }
}
