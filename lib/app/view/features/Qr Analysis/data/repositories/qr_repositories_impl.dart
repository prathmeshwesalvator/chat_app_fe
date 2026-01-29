import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/data/datasource/qr_datasource.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/data/model/qr_model.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/entities/qr_entities.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/repositories/qr_repositories.dart';
import 'package:dartz/dartz.dart';

class QrRepositoriesIMmpl implements QrRepositories {
  final QrDatasource qrDatasource;

  QrRepositoriesIMmpl({required this.qrDatasource});

  @override
  Future<Either<Failure, QrEntities>> generateHash() async {
    try {
      final response = await qrDatasource.generateHash();

      return Right(response.toDomain());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
