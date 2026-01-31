import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/widgets/contacts_list.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return const ContactsList();
  }
}
