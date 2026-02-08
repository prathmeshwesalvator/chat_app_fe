import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_bloc.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_event.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_state.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/message_input.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/widgets/chat_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ContactChatPage extends StatefulWidget {
  const ContactChatPage(
      {super.key,
      @PathParam('contactId') required this.contactId,
      @PathParam('contactUsername') required this.contactUsername});
  final int contactId;
  final String contactUsername;

  @override
  State<ContactChatPage> createState() => _ContactChatPageState();
}

class _ContactChatPageState extends State<ContactChatPage> {
  final TextEditingController textEditingController = TextEditingController();

  String generateRoomName(String user1, String user2) {
    final users = [user1.toLowerCase(), user2.toLowerCase()]..sort();
    return "${users[0]}_${users[1]}";
  }

  @override
  void initState() {
    final username = context.read<HomeBloc>().state.username;
    final roomName = generateRoomName(username, widget.contactUsername);
    context.read<HomeBloc>().add(ConnectSocketEvent(roomName: roomName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: ChatArea()),
        MessageInput(
          messageController: textEditingController,
          receiver: widget.contactId,
        )
      ],
    );
  }
}
