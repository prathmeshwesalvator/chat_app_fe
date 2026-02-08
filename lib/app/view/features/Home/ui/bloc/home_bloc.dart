import 'dart:async';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/entities/message_entities.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/usecases/home_socket_usecases.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/usecases/home_usecases.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_event.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUsecases homeUsecases;
  final HomeSocketUsecases homeSocketUsecases;

  StreamSubscription? _streamSubscription;

  HomeBloc({
    required this.homeUsecases,
    required this.homeSocketUsecases,
  }) : super(const HomeState()) {
    on<LoadUserProfileEvent>(_loadUserProfile);
    on<LogoutUserEvent>(_logoutUser);
    on<ConnectSocketEvent>(_connectSocket);
    on<DisconnectSocketEvent>(_disconnectSocket);
    on<SendMessageEvent>(_sendMessage);
    on<MessageReceivedEvent>(_onMessageReceived);
  }

  Future<void> _loadUserProfile(
    LoadUserProfileEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(profileStatus: Blocstatus.loading));

    final response = await homeUsecases.fetchUserProfile();

    response.fold(
      (l) => emit(
        state.copyWith(
          profileStatus: Blocstatus.error,
          errorMessage: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          profileStatus: Blocstatus.success,
          username: r.username,
          userId: r.userId,
          email: r.email,
          dateJoined: r.dateJoined,
          message: r.message,
        ),
      ),
    );
  }

  Future<void> _logoutUser(
    LogoutUserEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(logOutStatus: Blocstatus.loading));

    final response = await homeUsecases.logOutUser();

    response.fold(
      (l) => emit(state.copyWith(logOutStatus: Blocstatus.error)),
      (r) => emit(
        state.copyWith(
          logOutStatus: Blocstatus.success,
          message: r,
        ),
      ),
    );
  }

  Future<void> _connectSocket(
    ConnectSocketEvent event,
    Emitter<HomeState> emit,
  ) async {
    await homeSocketUsecases.connect(roomName: event.roomName);

    await _streamSubscription?.cancel();

    _streamSubscription = homeSocketUsecases.messages().listen(
          (msg) => add(MessageReceivedEvent(msg)),
        );
  }

  Future<void> _disconnectSocket(
    DisconnectSocketEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;

    homeSocketUsecases.disconnect();
  }

  void _sendMessage(
    SendMessageEvent event,
    Emitter<HomeState> emit,
  ) {
    homeSocketUsecases.sendMessage(
      sender: event.sender,
      receiver: event.receiver,
      message: event.message,
    );
  }

  void _onMessageReceived(
    MessageReceivedEvent event,
    Emitter<HomeState> emit,
  ) {
    final updatedMessages = List<MessageEntities>.from(state.messages)
      ..add(event.message);

    emit(state.copyWith(messages: updatedMessages));
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    homeSocketUsecases.disconnect();
    return super.close();
  }
}
