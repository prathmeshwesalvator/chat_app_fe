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
          right: BorderSide(color: theme.dividerColor.withAlpha((0.2 * 255).round())),
            left: BorderSide(color: theme.dividerColor.withAlpha((0.2 * 255).round())),
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          cacheExtent: 600,
          slivers: <Widget>[
            /// 🔍 Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomSearchBar(
                  searchController: _searchController,
                  onChanged: (value) {},
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Divider(
                height: 1,
                color: theme.dividerColor.withAlpha((0.2 * 255).round()),
              ),
            ),

            /// Section Title
            SliverToBoxAdapter(
              child: Padding(
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
                      color: theme.colorScheme.onSurface.withAlpha((0.6 * 255).round()),
                    ),
                  ],
                ),
              ),
            ),

            /// Chat List
            SliverFixedExtentList(
              itemExtent: 60,
              delegate: SliverChildBuilderDelegate((context, index) {
                return RepaintBoundary(
                  child: ChatTile(
                    name: 'User $index',
                    lastMessage: 'Last message preview...',
                    time: '12:${index}0 PM',
                    onTap: () {},
                  ),
                );
              }, childCount: 600),
            ),
          ],
        ),
      ),
    );
  }
}
