import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/entities/current_user_entities.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/repositories/home_repositories.dart';
import 'package:dartz/dartz.dart';

abstract class HomeUsecases {
  Future<Either<Failure, CurrentUserEntities>> fetchUserProfile();
  Future<Either<Failure, String>> logOutUser();
}

class HomeUsecasesImpl implements HomeUsecases {
  HomeUsecasesImpl({
    required this.homeRepositories,
    required this.localstorage,
  });

  final HomeRepositories homeRepositories;
  final Localstorage localstorage;

  @override
  Future<Either<Failure, CurrentUserEntities>> fetchUserProfile() async {
    return await homeRepositories.fetchUserProfile();
  }

  @override
  Future<Either<Failure, String>> logOutUser() async {
    try {
      await localstorage.pref.clear();
      return const Right('User Log Out Successfully');
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
