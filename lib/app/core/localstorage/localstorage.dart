import 'package:shared_preferences/shared_preferences.dart';

class Localstorage {
  final SharedPreferences pref;

  Localstorage({required this.pref});

  Future<String> getToken() async {
    return pref.getString('accessToken') ?? '';
  }

  Future<void> writeValue(String key, value) async {
    await pref.setString(key, value);
  }

  Future<void> writeAccessToken(final String value) async {
    await pref.setString('accessToken', value);
  }

  Future<void> writeRefreshToken(final String value) async {
    await pref.setString('refreshToken', value);
  }

  Future<String> readValue(final String key) async {
    return pref.getString(key) ?? 'User';
  }
}
