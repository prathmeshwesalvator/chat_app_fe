
import 'package:chat_app_fe/app/core/networking/request_annotations.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/data/models/contact_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'contacts_service.g.dart';

@RestApi()
abstract class ContactsService {

  factory ContactsService(Dio dio) = _ContactsService;

  @GET('/contacts/')
  @RequestAnnotations.requestTypeE
  Future<List<ContactModel>> fetchContacts();
}