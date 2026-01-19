import 'package:auto_route/auto_route.dart';
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
  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return SafeArea(
      child: Column(
        children: [
          /// 🔝 Fixed Header
          const HeaderBar(),

          const SizedBox(height: 8),

          /// 🟢 Scrollable chat list
          Expanded(
            child: CustomScrollView(
              cacheExtent: 300,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverFixedExtentList(
                    itemExtent: 60,
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return RepaintBoundary(
                        child: ChatTile(
                          name: 'name $index',
                          lastMessage: 'lastMessage',
                          time: 'time',
                        ),
                      );
                    }, childCount: 600),
                  ),
                ),
              ],
            ),
          ),

          /// ⌨️ Input field container (FIXED)
          MessageInput(messageController: messageController),
        ],
      ),
    );
  }
}
