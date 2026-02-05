abstract class HomeEvent {
  const HomeEvent();
}

class LoadUserProfileEvent extends HomeEvent {}

class LogoutUserEvent extends HomeEvent {}

class ConnectSocketEvent extends HomeEvent {}

class DisconnectSocketEvent extends HomeEvent {}

class SendMessageEvent extends HomeEvent {
  final int sender;
  final int receiver;
  final String message;

  const SendMessageEvent({
    required this.sender,
    required this.receiver,
    required this.message,
  });
}


class MessageReceivedEvent extends HomeEvent {
  final dynamic message;

  const MessageReceivedEvent(this.message);

}