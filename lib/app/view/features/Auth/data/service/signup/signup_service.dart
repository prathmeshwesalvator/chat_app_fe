import 'package:chat_app_fe/app/core/networking/request_annotations.dart';
import 'package:chat_app_fe/app/global/success/success.dart';
import 'package:chat_app_fe/app/view/features/Auth/data/models/signup/signup_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'signup_service.g.dart';

@RestApi()
abstract class SignUpService {
  factory SignUpService(Dio dio) = _SignUpService;

  @POST('/send-otp/')
  @RequestAnnotations.requestTypeC
  Future<Success> sendOtp(@Body() Map<String, dynamic> body);

  @POST('/verify-otp/')
  @RequestAnnotations.requestTypeC
  Future<Success> verifyOtp(@Body() Map<String, dynamic> body);

  @POST('/signup/')
  @RequestAnnotations.requestTypeC
  Future<SignupModel> signupSubmit(@Body() Map<String, dynamic> body);
}
