import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/chat_list.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/header_bar.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/message_input.dart';
import 'package:flutter/material.dart';


@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderBar(),
        const SizedBox(height: 8),
        const ChatList(),
        MessageInput(messageController: messageController),
      ],
    );
  }
}
