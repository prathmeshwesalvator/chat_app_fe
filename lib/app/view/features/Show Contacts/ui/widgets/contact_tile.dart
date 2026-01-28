import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/entities/contact_entities.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_bloc.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactTile extends StatefulWidget {
  const ContactTile({super.key, required this.contact});
  final ContactEntities contact;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final contact = widget.contact;

    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        return RepaintBoundary(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              radius: 22,
              backgroundColor: colorScheme.primary,
              child: Icon(Icons.person, color: colorScheme.secondary),
            ),
            title: Text(
              contact.contactUsername,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              'Last message preview...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
            trailing: Text(
              contact.createdAt,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.outline,
              ),
            ),
            onTap: () {
              // open chat
            },
          ),
        );
      },
    );
  }
}
