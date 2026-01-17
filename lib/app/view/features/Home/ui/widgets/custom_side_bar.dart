import 'package:chat_app_fe/app/view/features/Home/ui/widgets/chat_tile.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class CustomSideBar extends StatefulWidget {
  const CustomSideBar({super.key});

  @override
  State<CustomSideBar> createState() => _CustomSideBarState();
}

class _CustomSideBarState extends State<CustomSideBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: theme.dividerColor.withOpacity(0.2),
          ),
          left: BorderSide(
            color: theme.dividerColor.withOpacity(0.2),
          ),
          
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            /// 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomSearchBar(
                searchController: _searchController,
                onChanged: (value) {
                },
              ),
            ),

            Divider(
              height: 1,
              color: theme.dividerColor.withOpacity(0.2),
            ),

            /// Section Title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Text(
                    'Chats',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 18,
                    color:
                        theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ],
              ),
            ),

            /// Chat List
            Expanded(
              child: ListView.builder(
                itemExtent: 60,
                cacheExtent: 60,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                physics: const BouncingScrollPhysics(),

                itemCount: 600,
                itemBuilder: (context, index) {
                  return RepaintBoundary(
                    child: ChatTile(
                      name: 'User $index',
                      lastMessage: 'Last message preview...',
                      time: '12:${index}0 PM',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
