import 'package:chat_app_fe/app/core/networking/request_annotations.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'authservice.g.dart';

@RestApi()
abstract class Authservice {

  factory Authservice(Dio dio) =_Authservice;

  @GET('/auth/check/')
  @RequestAnnotations.requestTypeE
  Future<void> validateToken();

}