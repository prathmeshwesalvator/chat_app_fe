abstract class QrEvent {}

class GenerateHash extends QrEvent {}

class GetUserInfo extends QrEvent {
  final Map<String,dynamic> body;

  GetUserInfo({required this.body});
}

class AddContact extends QrEvent {
  final Map<String, dynamic> body;

  AddContact({required this.body});
}
