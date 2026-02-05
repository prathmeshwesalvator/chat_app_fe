abstract class WebsocketService {
  Stream<dynamic> get listen;
  void send(dynamic data);
  void connect({required Uri url});
  void disconnect();
}
