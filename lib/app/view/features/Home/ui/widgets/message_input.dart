import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key, required this.messageController});
  final TextEditingController messageController;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    widget.messageController.addListener(() {
      setState(() {
        hasText = widget.messageController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,

          /// 🔹 Rounded outer edges
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),

          /// 🔹 Subtle elevation from bottom
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],

          /// 🔹 Hairline top separator (very premium touch)
          border: Border(
            top: BorderSide(color: theme.dividerColor.withOpacity(0.15)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// Emoji button
            IconButton(
              icon: Icon(
                Icons.emoji_emotions_outlined,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              onPressed: () {},
            ),

            /// Text Field
            Expanded(
              child: TextFormField(
                controller: widget.messageController,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  filled: true,
                  fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            /// Send Button
            AnimatedScale(
              scale: hasText ? 1 : 0.9,
              duration: const Duration(milliseconds: 200),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: hasText
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withOpacity(0.4),
                child: IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    size: 20,
                    color: theme.colorScheme.onPrimary,
                  ),
                  onPressed: hasText ? () {} : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
