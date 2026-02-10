import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/datasource/login/login_data_source.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/models/login/login_model.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/entities/login_entities.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/repositories/login_repositories.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoriesImpl implements LoginRepositories {
  final LoginDataSource loginDataSource;
  final Localstorage localstorage;

  LoginRepositoriesImpl({
    required this.loginDataSource,
    required this.localstorage,
  });

  @override
  Future<Either<Failure, LoginEntities>> loginUser(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await loginDataSource.loginUser(body);

      localstorage.writeAccessToken(value: response.accessToken);
      localstorage.writeRefreshToken(value: response.refreshToken);

      return Right(response.toDomain());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
