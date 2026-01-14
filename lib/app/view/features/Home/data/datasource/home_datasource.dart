import 'package:chat_app_fe/app/view/features/Home/data/models/current_user.dart';
import 'package:chat_app_fe/app/view/features/Home/data/service/home_service.dart';

abstract class HomeDatasource {
  Future<CurrentUser> fetchUserProfile();
}

class HomeDatasourceImpl implements HomeDatasource {
  final HomeService homeService;

  HomeDatasourceImpl({required this.homeService});

  @override
  Future<CurrentUser> fetchUserProfile() async {
    try {


      final response = await homeService.fetchUserProfile();

      return response;
    } catch (e) {
      throw Exception('An Error Ocurred $e');
    }
  }
}
