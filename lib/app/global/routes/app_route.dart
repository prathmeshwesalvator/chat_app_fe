import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/core/auth/authguard.dart';
import 'package:chat_app_fe/app/core/auth/authservice.dart';
import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/core/networking/api_extensions.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/home_page.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/login_page.dart';
import 'package:chat_app_fe/main.dart';
part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRoute extends RootStackRouter {
  @override
  List<AutoRoute> routes = [
    CustomRoute(
      page: LoginRoute.page,
      initial: true,
      path: '/',
      transitionsBuilder: TransitionsBuilders.slideRightWithFade,
      duration: 300.milliseconds,
    ),

    CustomRoute(
      page: HomeRoute.page,
      path: '/home',
      guards: [
        Authguard(
          localstorage: getIt<Localstorage>(),
          authservice: getIt<Authservice>(),
        ),
      ],
      transitionsBuilder: TransitionsBuilders.slideRightWithFade,
      duration: 300.milliseconds,
    ),
  ];
}
