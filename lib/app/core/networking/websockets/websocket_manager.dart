import 'dart:convert';

import 'package:chat_app_fe/app/core/networking/websockets/websocket_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketManager implements WebsocketService {
  WebSocketChannel? _channel;
  Stream<dynamic>? _broadcastStream;

  @override
  void connect({required Uri url}) {
    if (_channel != null) return;

    _channel = WebSocketChannel.connect(url);
    _broadcastStream = _channel!.stream.asBroadcastStream();
  }

  @override
  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    _broadcastStream = null;
  }

  @override
  Stream<dynamic> get listen {
    if (_broadcastStream == null) {
      throw Exception('Websocket is not connected');
    }
    return _broadcastStream!;
  }

  @override
  void send(data) {
    _channel?.sink.add(jsonEncode(data));
  }
}
