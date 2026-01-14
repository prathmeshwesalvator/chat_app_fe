import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/core/networking/api_contsants.dart';
import 'package:chat_app_fe/app/core/networking/request_annotations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiInterceptors extends Interceptor {
  final Localstorage localstorage;

  ApiInterceptors({required this.localstorage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requestType = options.extra[RequestAnnotations.requestType];
    final token = await localstorage.getToken();

    switch (requestType) {
      case RequestAnnotations.typeA:
        options.headers[ApiConstants.authorization] = "Bearer $token";
        options.headers[ApiConstants.contentType] = ApiConstants.contentJson;
        break;

      case RequestAnnotations.typeB:
        options.headers[ApiConstants.authorization] = "Bearer $token";
        break;

      case RequestAnnotations.typeC:
        options.headers[ApiConstants.contentType] = ApiConstants.contentJson;
        break;

      case RequestAnnotations.typeD:
        break;

      case RequestAnnotations.typeE:
        options.headers[ApiConstants.authorization] = "Bearer $token";
        break;

      default:
        debugPrint('No RequestAnnotation found for this API call');
    }

    options.extra.remove(RequestAnnotations.requestType);
    handler.next(options);
  }
}
