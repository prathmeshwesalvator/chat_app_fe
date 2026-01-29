import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/qr_entities.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/repositories/qr_repositories.dart';
import 'package:dartz/dartz.dart';

abstract class QrUsecases {
  Future<Either<Failure, QrEntities>> generateHash();
}

class QrUsecasesImpl implements QrUsecases {
  final QrRepositories qrRepositories;

  QrUsecasesImpl({required this.qrRepositories});

  @override
  Future<Either<Failure, QrEntities>> generateHash() async {
    return await qrRepositories.generateHash();
  }
}
