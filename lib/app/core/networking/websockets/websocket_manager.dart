import 'dart:convert';
import 'package:chat_app_fe/app/core/networking/websockets/websocket_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketManager implements WebsocketService {
  WebSocketChannel? _channel;

  @override
  void connect({required String url}) {
    if (_channel != null) {
      return;
    }

    _channel = WebSocketChannel.connect(
      Uri.parse(url),
    );
  }

  @override
  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }

  @override
  Future<Stream<dynamic>> get listen async{
    if (_channel == null) {
      throw Exception('Websocket is not connected');
    }
    return _channel!.stream;
  }

  @override
  void send(data) {
    _channel?.sink.add(jsonEncode(data));
  }

  WebSocketChannel get channel {
    if (_channel == null) {
      throw Exception('WEbsocket is not connected');
    }
    return _channel!;
  }
}
