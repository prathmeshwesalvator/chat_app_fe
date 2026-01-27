
import 'package:chat_app_fe/app/core/networking/request_annotations.dart';
import 'package:chat_app_fe/app/view/features/Login/data/models/login_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'login_service.g.dart';

@RestApi()
abstract class LoginService {


  factory LoginService(Dio dio) = _LoginService;

  @POST('/token/')
  @RequestAnnotations.requestTypeC
  Future<LoginModel> loginUser (
    @Body() Map<String , dynamic> body 
  );
}