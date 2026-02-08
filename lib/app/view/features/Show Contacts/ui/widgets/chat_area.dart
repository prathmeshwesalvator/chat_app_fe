import 'package:chat_app_fe/app/view/features/Home/domain/entities/message_entities.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_bloc.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatArea extends StatefulWidget {
  const ChatArea({super.key});

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (prev, curr) => prev.messages.length != curr.messages.length,
      listener: (_, __) => _scrollToBottom(),
      buildWhen: (prev, curr) => prev.messages.length != curr.messages.length,
      builder: (context, state) {
        if (state.messages.isEmpty) {
          return _EmptyChatState();
        }

        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              sliver: SliverList.builder(
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  final message = state.messages[index];

                  return _MessageBubble(message: message);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final MessageEntities message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.read<HomeBloc>().state;
    final bool isMe = message.sender.toString() == state.userId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
        decoration: BoxDecoration(
        color: isMe
          ? theme.colorScheme.primary
          : theme.brightness == Brightness.light
            ? theme.colorScheme.primary.withAlpha((0.08 * 255).round())
            : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isMe
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// If timestamp exists in entity → show here
                  if (message.timestamp != null)
                    Text(
                      'check',
                      style: theme.textTheme.labelSmall?.copyWith(
              color: isMe
                ? theme.colorScheme.onPrimary.withAlpha((0.7 * 255).round())
                : theme.colorScheme.onSurfaceVariant
                  .withAlpha((0.7 * 255).round()),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyChatState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 60,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(
            "Start Conversation",
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            "Send a message to begin chatting",
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
