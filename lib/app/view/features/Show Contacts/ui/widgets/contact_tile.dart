import 'package:chat_app_fe/app/global/utils/conversion_methods.dart';
import 'package:chat_app_fe/app/global/utils/device_identification.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/entities/contact_entities.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatefulWidget {
  const ContactTile({
    super.key,
    required this.contact,
    required this.onTap,
    required this.onDeleteTap,
  });

  final ContactEntities contact;
  final VoidCallback onTap;
  final VoidCallback onDeleteTap;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return RepaintBoundary(
      child: GestureDetector(
        onLongPress: isDesktop(context)
            ? null
            : () {
                _showDeleteBottomSheet(context, widget.onDeleteTap);
              },
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.98 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest
                  .withAlpha((0.4 * 255).round()),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color:
                    colorScheme.outlineVariant.withAlpha((0.5 * 255).round()),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  _Avatar(contact: widget.contact),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.contact.contactUsername,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (isDesktop(context))
                              _buildDesktopMenu(context, widget.onDeleteTap),
                            if (!isDesktop(context))
                              Text(
                                ConversionMethods.formatDate(
                                    widget.contact.createdAt),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.outline,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        /// Last Message
                        Text(
                          'Last message preview...',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.contact});

  final ContactEntities contact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withAlpha((0.1 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 26,
        backgroundColor: colorScheme.primaryContainer,
        child: Icon(
          Icons.person_rounded,
          color: colorScheme.onPrimaryContainer,
          size: 28,
        ),
      ),
    );
  }
}

void _showDeleteBottomSheet(BuildContext context, VoidCallback onDeleteTap) {
  final colorScheme = Theme.of(context).colorScheme;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.delete_rounded,
                  color: colorScheme.error,
                ),
                title: Text(
                  "Delete Contact",
                  style: TextStyle(
                    color: colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDelete(context, onDeleteTap);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _confirmDelete(BuildContext context, VoidCallback onDeleteTap) {
  final colorScheme = Theme.of(context).colorScheme;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Contact"),
      content: const Text("Are you sure you want to delete this contact?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onDeleteTap();
          },
          child: Text(
            "Delete",
            style: TextStyle(color: colorScheme.error),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDesktopMenu(BuildContext context, VoidCallback onDeleteTap) {
  final colorScheme = Theme.of(context).colorScheme;

  return PopupMenuButton(
    icon: const Icon(Icons.more_vert_rounded),
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(Icons.delete_rounded, color: colorScheme.error, size: 20),
            const SizedBox(width: 8),
            Text(
              "Delete Contact",
              style: TextStyle(color: colorScheme.error),
            ),
          ],
        ),
      ),
    ],
    onSelected: (value) {
      if (value == 'delete') {
        _confirmDelete(context, onDeleteTap);
      }
    },
  );
}
