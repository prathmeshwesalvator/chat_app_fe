
import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/entities/current_user_entities.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/repositories/home_repositories.dart';
import 'package:dartz/dartz.dart';

abstract class HomeUsecases {
  Future<Either<Failure, CurrentUserEntities>> fetchUserProfile();
}

class HomeUsecasesImpl implements HomeUsecases {
  HomeUsecasesImpl({required this.homeRepositories});

  final HomeRepositories homeRepositories;

  @override
  Future<Either<Failure, CurrentUserEntities>> fetchUserProfile() async {
    return await homeRepositories.fetchUserProfile();
  }
}
