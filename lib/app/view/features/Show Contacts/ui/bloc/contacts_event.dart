import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/entities/contact_entities.dart';

abstract class ContactsEvent {}

class LoadContacts extends ContactsEvent {}

class UpdateContacts extends ContactsEvent {
  final ContactEntities contact;

  UpdateContacts({required this.contact});
}
