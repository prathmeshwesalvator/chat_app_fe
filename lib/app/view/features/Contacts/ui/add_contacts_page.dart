import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';



@RoutePage()
class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('this is add contacts'));
  }
}
