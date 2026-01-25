import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/chat_list.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/chat_tile.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/header_bar.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/message_input.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const HeaderBar(),

          const SizedBox(height: 8),

          const ChatList(),

          MessageInput(messageController: messageController),
        ],
      ),
    );
  }
}
