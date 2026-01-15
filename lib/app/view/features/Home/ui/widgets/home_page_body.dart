import 'package:chat_app_fe/app/global/utils/device_identification.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/recent_chats_list.dart';
import 'package:flutter/material.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return isDesktop(context)
        ? const Row(
            children: [
              Expanded(child: RecentChatsList()),
              Expanded(flex: 3, child: Center(child: Text('Profile Loaded'))),
            ],
          )
        : const RecentChatsList();
  }
}
