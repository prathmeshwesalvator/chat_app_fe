import 'package:chat_app_fe/app/core/networking/request_annotations.dart';
import 'package:chat_app_fe/app/view/features/Home/data/models/current_user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'home_service.g.dart';

@RestApi()
abstract class HomeService {
  factory HomeService(Dio dio) = _HomeService;

  @GET('/auth/me/')
  @RequestAnnotations.requestTypeA
  Future<CurrentUser> fetchUserProfile();
}
