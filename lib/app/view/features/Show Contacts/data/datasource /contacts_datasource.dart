import 'package:chat_app_fe/app/view/features/Show%20Contacts/data/models/contact_model.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/data/service/contacts_service.dart';

abstract class ContactsDatasource {
  Future<List<ContactModel>> fetchContacts();
}

class ContactsDatasourceImpl implements ContactsDatasource {
  final ContactsService contactsService;

  ContactsDatasourceImpl({required this.contactsService});

  @override
  Future<List<ContactModel>> fetchContacts() async {
    try {
      final response = await contactsService.fetchContacts();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
