import 'dart:convert';

import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/core/networking/api_contsants.dart';
import 'package:chat_app_fe/app/core/networking/websockets/websocket_service.dart';
import 'package:chat_app_fe/app/view/features/Home/data/models/message_model.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/entities/message_entities.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/repositories/home_socket_repositories.dart';

class HomeSocketRepositoryImpl implements HomeSocketRepositories {
  final WebsocketService websocketService;
  final Localstorage localstorage;

  HomeSocketRepositoryImpl({
    required this.websocketService,
    required this.localstorage,
  });

  @override
  Future<void> connect({required String roomName}) async {
    final token = await localstorage.getToken();

    websocketService.connect(
      url: Uri.parse('${ApiConstants.webSocketUrl}/$roomName/')
          .replace(queryParameters: {'token': token}),
    );
  }

  @override
  void sendMessage(Map<String, dynamic> data) {
    websocketService.send(data);
  }

  @override
  Stream<MessageEntities> messages() {
    return websocketService.listen
        .where((event) => event is String)
        .map((event) {
      final decoded = jsonDecode(event as String);

      final entity = MessageModel.fromJson(
        Map<String, dynamic>.from(decoded),
      ).toDomain();

      return entity;
    }).where((msg) => msg.type == 'chat');
  }

  @override
  void disconnect() {
    websocketService.disconnect();
  }
}
