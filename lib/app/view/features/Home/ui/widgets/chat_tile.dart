import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
  });

  final String name;
  final String lastMessage;
  final String time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        context.router.push(const ChatRoute());
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            /// Avatar
            CircleAvatar(
              radius: 22,
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                name[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(width: 12),

            /// Name + Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            /// Time
            Text(
              time,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
