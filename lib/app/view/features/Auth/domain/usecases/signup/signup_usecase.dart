import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/global/success/success.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/entities/signup_user_entity.dart';
import 'package:chat_app_fe/app/view/features/Auth/domain/repositories/signup/sign_up_repositories.dart';
import 'package:dartz/dartz.dart';

abstract class SignupUsecases {
  Future<Either<Failure, Success>> sendOtp({required String email});
  Future<Either<Failure, Success>> verifyOtp(
      {required String otp, required String email});

  Future<Either<Failure, SignupUserEntity>> signupSubmit(
      {required String username,
      required String email,
      required String password});
}

class SignupUsecaseImpl implements SignupUsecases {
  final SignUpRepositories signUpRepositories;

  SignupUsecaseImpl({required this.signUpRepositories});
  @override
  Future<Either<Failure, Success>> sendOtp({required String email}) async {
    final Map<String, dynamic> body = {'email': email};
    return await signUpRepositories.sendOtp(body: body);
  }

  @override
  Future<Either<Failure, Success>> verifyOtp(
      {required String otp, required String email}) async {
    final Map<String, dynamic> body = {'email': email, 'otp': otp};

    return await signUpRepositories.verifyOtp(body: body);
  }

  @override
  Future<Either<Failure, SignupUserEntity>> signupSubmit(
      {required String username,
      required String email,
      required String password}) async {
    final Map<String, dynamic> body = {
      'username': username,
      'email': email,
      'password': password
    };
    return await signUpRepositories.signupSubmit(body: body);
  }
}
