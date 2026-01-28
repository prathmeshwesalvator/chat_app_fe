import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_bloc.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_state.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        return CustomScrollView(
          cacheExtent: 300,
          slivers: [
            SliverPadding(
              sliver: SliverFixedExtentList.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  return ContactTile(contact: state.contacts[index]);
                },
                itemExtent: 79,
              ),
              padding: const EdgeInsetsGeometry.all(8),
            ),
          ],
        );
      },
    );
    ;
  }
}
