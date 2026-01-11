import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/core/networking/api_contsants.dart';
import 'package:chat_app_fe/app/core/networking/request_annotations.dart';
import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  final Localstorage localstorage;

  ApiInterceptors({required this.localstorage});
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    switch (options.extra[RequestAnnotations.requestType]) {
      case RequestAnnotations.typeA:
        options.headers[ApiConstants.authorization] =
            "Bearer ${await localstorage.getToken()}";
        options.headers[ApiConstants.contentType] = ApiConstants.contentJson;
      case RequestAnnotations.typeB:
        options.headers[ApiConstants.authorization] = await localstorage
            .getToken();
        options.headers[ApiConstants.contentType] =
            ApiConstants.contentMultipart;

      case RequestAnnotations.typeC:
        options.headers[ApiConstants.contentType] = ApiConstants.contentJson;

      case RequestAnnotations.typeD:
        options.headers[ApiConstants.contentType] =
            ApiConstants.contentMultipart;
      case RequestAnnotations.typeE:
        options.headers[ApiConstants.authorization] =
            "Bearer ${await localstorage.getToken()}";
    }

    options.extra.remove(RequestAnnotations.requestType);

    return handler.next(options);
  }
}
