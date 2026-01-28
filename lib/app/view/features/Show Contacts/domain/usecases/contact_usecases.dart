import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/entities/contact_entities.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/repositories/contact_repositories.dart';
import 'package:dartz/dartz.dart';

abstract class ContactUsecases {
  Future<Either<Failure, List<ContactEntities>>> fetchContacts();
}

class ContactUsecasesImpl implements ContactUsecases {
  final ContactRepositories contactRepositories;

  ContactUsecasesImpl({required this.contactRepositories});

  Future<Either<Failure, List<ContactEntities>>> fetchContacts() async {
    return await contactRepositories.fetchContacts();
  }
}
