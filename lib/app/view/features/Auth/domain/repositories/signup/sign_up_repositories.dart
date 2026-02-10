import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/global/success/success.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/entities/signup_user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpRepositories {
  Future<Either<Failure, Success>> sendOtp(
      {required Map<String, dynamic> body});

  Future<Either<Failure, Success>> verifyOtp(
      {required Map<String, dynamic> body});

  Future<Either<Failure, SignupUserEntity>> signupSubmit(
      {required Map<String, dynamic> body});
}
