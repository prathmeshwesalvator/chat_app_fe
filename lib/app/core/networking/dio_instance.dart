
import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/core/networking/api_contsants.dart';
import 'package:chat_app_fe/app/core/networking/api_extensions.dart';
import 'package:chat_app_fe/app/core/networking/api_interceptors.dart';
import 'package:chat_app_fe/main.dart';
import 'package:dio/dio.dart';

class DioInstance {
  final Dio dio;

  DioInstance()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: 5.seconds,
          sendTimeout: 5.seconds,
          receiveTimeout: 5.seconds,
        ),
      )..interceptors.addAll([ApiInterceptors(localstorage: getIt<Localstorage>())]);
}
