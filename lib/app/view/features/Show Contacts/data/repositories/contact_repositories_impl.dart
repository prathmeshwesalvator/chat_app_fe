import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/data/datasource%20/contacts_datasource.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/data/models/contact_model.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/entities/contact_entities.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/repositories/contact_repositories.dart';
import 'package:dartz/dartz.dart';

class ContactRepositoriesImpl implements ContactRepositories {
  final ContactsDatasource contactsDatasource;

  ContactRepositoriesImpl({required this.contactsDatasource});

  @override
  Future<Either<Failure, List<ContactEntities>>> fetchContacts() async {
    try {
      final response = await contactsDatasource.fetchContacts();
      return Right(response.map((e) => e.toDomain()).toList());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
