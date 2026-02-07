import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/qr_entities.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/user_info_entities.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/repositories/qr_repositories.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/entities/contact_entities.dart';
import 'package:dartz/dartz.dart';

abstract class QrUsecases {
  Future<Either<Failure, QrEntities>> generateHash();
  Future<Either<Failure, UserInfoEntities>> getInfo(Map<String, dynamic> body);
  Future<Either<Failure, ContactEntities>> addContact(
      {required Map<String, dynamic> body});
}

class QrUsecasesImpl implements QrUsecases {
  final QrRepositories qrRepositories;

  QrUsecasesImpl({required this.qrRepositories});

  @override
  Future<Either<Failure, QrEntities>> generateHash() async {
    return await qrRepositories.generateHash();
  }

  @override
  Future<Either<Failure, UserInfoEntities>> getInfo(
      Map<String, dynamic> body) async {
    return await qrRepositories.getInfo(body);
  }

  @override
  Future<Either<Failure, ContactEntities>> addContact(
      {required Map<String, dynamic> body}) async {
    return await qrRepositories.addContact(body);
  }
}
