import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/global/success/success.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/datasource/signup/signup_data_source.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/models/signup/signup_model.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/entities/signup_user_entity.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/repositories/signup/sign_up_repositories.dart';
import 'package:dartz/dartz.dart';

class SignUpRepositoriesImpl implements SignUpRepositories {
  final SignupDataSource signupDataSource;

  SignUpRepositoriesImpl(
      {required this.signupDataSource, required this.localstorage});
  final Localstorage localstorage;
  @override
  Future<Either<Failure, Success>> sendOtp(
      {required Map<String, dynamic> body}) async {
    try {
      final response = await signupDataSource.sendOtp(body: body);
      return Right(response);
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> verifyOtp(
      {required Map<String, dynamic> body}) async {
    try {
      final response = await signupDataSource.verifyOtp(body: body);
      return Right(response);
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SignupUserEntity>> signupSubmit(
      {required Map<String, dynamic> body}) async {
    try {
      final response = await signupDataSource.signupSubmit(body: body);

      await localstorage.writeAccessToken(value: response.accessToken);
      await localstorage.writeRefreshToken(value: response.refreshToken);

      return Right(response.toDomain());
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
