import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_bloc.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_state.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/widgets/contact_tile.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/widgets/contact_shimmer_tile.dart';
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
        if (state.contactStatus == Blocstatus.loading) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverFixedExtentList.builder(
                  itemCount: 8, // shimmer count
                  itemExtent: 79,
                  itemBuilder: (_, __) => const ContactShimmerTile(),
                ),
              ),
            ],
          );
        }

        /// ✅ SHOW REAL DATA
        return CustomScrollView(
          cacheExtent: 300,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverFixedExtentList.builder(
                itemCount: state.contacts.length,
                itemExtent: 79,
                itemBuilder: (context, index) {
                  return ContactTile(
                    contact: state.contacts[index],
                    onTap: () {
                      context.router.push(
                        ContactChatRoute(
                          contactId: state.contacts[index].contactUserId,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
