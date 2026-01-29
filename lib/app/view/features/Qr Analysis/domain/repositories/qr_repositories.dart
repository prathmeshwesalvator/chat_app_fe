import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/qr_entities.dart';
import 'package:dartz/dartz.dart';

abstract class QrRepositories {
  Future<Either<Failure, QrEntities>> generateHash();
}
