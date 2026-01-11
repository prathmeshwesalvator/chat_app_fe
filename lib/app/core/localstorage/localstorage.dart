import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Localstorage {
  final FlutterSecureStorage pref;

  Localstorage({required this.pref});

  Future<String> getToken() async {
    return await pref.read(key: 'accessToken') ?? '';
  }

  Future<void> writeValue(String key,  value) async {
    await pref.write(key: key, value: value);
  }

  Future<void> writeAccessToken(final String value) async {
    await pref.write(key: 'accessToken', value: value);
  }

  Future<void> writeRefreshToken(final String value) async {
    await pref.write(key: 'refreshToken', value: value);
  }
}
