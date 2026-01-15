import 'package:chat_app_fe/app/view/features/Home/ui/widgets/chat_list.dart';
import 'package:flutter/material.dart';

class RecentChatsList extends StatefulWidget {
  const RecentChatsList({super.key});

  @override
  State<RecentChatsList> createState() => _RecentChatsListState();
}

class _RecentChatsListState extends State<RecentChatsList> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController searchController = TextEditingController();

    return  Column(
      spacing: 8,
      children: [
      TextFormField(
        controller: searchController,
        autofocus: true,
        cursorOpacityAnimates: true,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(8),
          labelText: 'Search' , 
          hintText: 'Enter Contact Name'
        ),
      ),


      const ChatList()
    ]);
  }
}
