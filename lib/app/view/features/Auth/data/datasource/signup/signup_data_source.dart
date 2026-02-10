import 'package:chat_app_fe/app/global/success/success.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/models/signup/signup_model.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/service/signup/signup_service.dart';

abstract class SignupDataSource {
  Future<Success> sendOtp({required Map<String, dynamic> body});
  Future<Success> verifyOtp({required Map<String, dynamic> body});
  Future<SignupModel> signupSubmit({required Map<String, dynamic> body});
}

class SignupDataSourceImpl implements SignupDataSource {
  final SignUpService signUpService;

  SignupDataSourceImpl({required this.signUpService});

  @override
  Future<Success> sendOtp({required Map<String, dynamic> body}) async {
    try {
      final response = await signUpService.sendOtp(body);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Success> verifyOtp({required Map<String, dynamic> body}) async {
    try {
      final response = await signUpService.verifyOtp(body);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SignupModel> signupSubmit({required Map<String, dynamic> body}) async {
    try {
      final response = await signUpService.signupSubmit(body);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
