import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_bloc.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ContactsTabPage extends StatefulWidget {
  const ContactsTabPage({super.key});

  @override
  State<ContactsTabPage> createState() => _ContactsTabPageState();
}

class _ContactsTabPageState extends State<ContactsTabPage> {
  @override
  void initState() {
    super.initState();
    context.read<ContactsBloc>().add(LoadContacts());
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: AutoRouter());
  }
}
