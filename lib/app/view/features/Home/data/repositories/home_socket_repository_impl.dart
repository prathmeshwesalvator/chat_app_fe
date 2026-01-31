import 'package:chat_app_fe/app/core/networking/api_contsants.dart';
import 'package:chat_app_fe/app/core/networking/websockets/websocket_service.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/repositories/home_socket_repositories.dart';

class HomeSocketRepositoryImpl implements HomeSocketRepositories {
  final WebsocketService websocketService;

  HomeSocketRepositoryImpl({required this.websocketService});

  @override
  void connect() {
    websocketService.connect(url: ApiConstants.webSocketUrl);
  }

  @override
  void sendMessage(Map<String, dynamic> data) {
    websocketService.send(data);
  }

  @override
  Future<Stream<dynamic>> messages() async{
    return await websocketService.listen;
  }

  @override
  void disconnect() {
    websocketService.disconnect();
  }
}
