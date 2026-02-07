import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/qr_entities.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/user_info_entities.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/entities/contact_entities.dart';
import 'package:dartz/dartz.dart';

abstract class QrRepositories {
  Future<Either<Failure, QrEntities>> generateHash();
  Future<Either<Failure, UserInfoEntities>> getInfo(Map<String, dynamic> body);
  Future<Either<Failure, ContactEntities>> addContact(
      Map<String, dynamic> body);
}
