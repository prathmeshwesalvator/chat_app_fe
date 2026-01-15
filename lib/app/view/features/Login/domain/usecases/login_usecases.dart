import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Login/domain/entities/login_entities.dart';
import 'package:chat_app_fe/app/view/features/Login/domain/repositories/login_repositories.dart';
import 'package:dartz/dartz.dart';

abstract class LoginUsecases {
  Future<Either<Failure, LoginEntities>> loginUser(
    final String username,
    final String password,
  );
}

class LoginUsecasesImpl implements LoginUsecases {
  final LoginRepositories loginRepositories;

  LoginUsecasesImpl({required this.loginRepositories});

  @override
  Future<Either<Failure, LoginEntities>> loginUser(
    final String username,
    final String password,
  ) async {
    final Map<String, dynamic> body = {'username': username, 'password': password};

    return await loginRepositories.loginUser(body);
  }
}
