import 'package:chat_app_fe/app/core/networking/request_annotations.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/data/model/qr_model.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/data/model/user_info_model.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/data/models/contact_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'qr_analysis_service.g.dart';

@RestApi()
abstract class QrAnalysisService {
  factory QrAnalysisService(Dio dio) = _QrAnalysisService;

  @GET('/qr-code/')
  @RequestAnnotations.requestTypeE
  Future<QrModel> generateHash();

  @POST('/qr-code/')
  @RequestAnnotations.requestTypeA
  Future<UserInfoModel> getInfo(@Body() Map<String, dynamic> body);

  @POST('/contacts/')
  @RequestAnnotations.requestTypeA
  Future<ContactModel> addContact(
    @Body() Map<String , dynamic> body
  );
}
