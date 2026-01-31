abstract class WebsocketService {
  Future<Stream<dynamic>> get listen;
  void send(dynamic data);
  void connect({required String url});
  void disconnect();
}
