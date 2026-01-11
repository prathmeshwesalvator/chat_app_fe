import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Login/domain/entities/login_entities.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepositories {
  Future<Either<Failure, LoginEntities>> loginUser(Map<String, dynamic> body);
}
