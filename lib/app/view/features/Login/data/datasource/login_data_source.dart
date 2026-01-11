import 'package:chat_app_fe/app/view/features/Login/data/models/login_model.dart';
import 'package:chat_app_fe/app/view/features/Login/data/service/login_service.dart';

abstract class LoginDataSource {
  Future<LoginModel> loginUser(Map<String, dynamic> body);
}

class LoginDataSourceImpl implements LoginDataSource {
  final LoginService loginService;

  LoginDataSourceImpl({required this.loginService});

  @override
  Future<LoginModel> loginUser(Map<String, dynamic> body) async {
    try {
      final response = await loginService.loginUser(body);

      return response;
    } catch (e) {
      throw Exception('An Error Occurred');
    }
  }
}
