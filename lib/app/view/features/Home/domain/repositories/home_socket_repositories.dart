abstract class HomeSocketRepositories {
  void connect();
  Future<Stream<dynamic>> messages();
  void sendMessage(Map<String, dynamic> data);
  void disconnect();
}
