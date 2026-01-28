import 'package:auto_route/annotations.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_bloc.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_event.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/widgets/contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ContactsBloc>().add(LoadContacts());
  }

  @override
  Widget build(BuildContext context) {
    return const ContactsList();
  }
}
