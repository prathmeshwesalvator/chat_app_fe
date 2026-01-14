import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Home/data/datasource/home_datasource.dart';
import 'package:chat_app_fe/app/view/features/Home/data/models/current_user.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/entities/current_user_entities.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/repositories/home_repositories.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoriesImpl implements HomeRepositories {
  final HomeDatasource homeDatasource;
  final Localstorage localstorage;

  HomeRepositoriesImpl({
    required this.homeDatasource,
    required this.localstorage,
  });

  @override
  Future<Either<Failure, CurrentUserEntities>> fetchUserProfile() async {
    try {

   
      final response = await homeDatasource.fetchUserProfile();

      await localstorage.writeValue('username', response.username);
      await localstorage.writeValue('email', response.email);
      await localstorage.writeValue('userId', response.userId);
      await localstorage.writeValue('dateJoined', response.dateJoined);

      return Right(response.toDomain());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
