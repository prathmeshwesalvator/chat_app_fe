import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ContactChatPage extends StatefulWidget {
  const ContactChatPage({super.key});

  @override
  State<ContactChatPage> createState() => _ContactChatPageState();
}

class _ContactChatPageState extends State<ContactChatPage> {
  @override
  Widget build(BuildContext context) {
    return const Text('This is contact chat page ');
  }
}
