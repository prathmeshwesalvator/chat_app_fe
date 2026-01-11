import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/entities/current_user_entities.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepositories {
  Future<Either<Failure, CurrentUserEntities>> fetchUserProfile();
}
