import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/core/auth/authservice.dart';
import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';

class Authguard extends AutoRouteGuard {
  final Localstorage localstorage;
  final Authservice authservice;

  Authguard({required this.localstorage, required this.authservice});

  @override
  FutureOr<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final token = await localstorage.getToken();

    if (token.isEmpty) {
      return router.replaceAll([LoginRoute()]);
    }

    return resolver.next();

    // try {
    //   await authservice.validateToken();

    //   return resolver.next();
    // } catch (e) {
    //   return router.replaceAll([LoginRoute()]);
    // }
  }
}
