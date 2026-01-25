import 'package:chat_app_fe/app/view/features/Home/ui/widgets/chat_tile.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              }, childCount: 4),
            ),
          ),
        ],
      ),
    );
  }
}
