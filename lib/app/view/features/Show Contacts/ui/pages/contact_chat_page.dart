import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/message_input.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/widgets/chat_area.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ContactChatPage extends StatefulWidget {
  const ContactChatPage({super.key, required this.contactId});
  final int contactId;

  @override
  State<ContactChatPage> createState() => _ContactChatPageState();
}

class _ContactChatPageState extends State<ContactChatPage> {
  final TextEditingController textEditingController = TextEditingController();
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
