import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/core/auth/authguard.dart';
import 'package:chat_app_fe/app/core/auth/authservice.dart';
import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/core/networking/api_extensions.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/home_page.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/pages/add_contacts_page.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/pages/home_tab_page.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/pages/profile_page.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/pages/settings_page.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/pages/show_qr_page.dart';
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
      path: '/login',
      transitionsBuilder: TransitionsBuilders.slideRightWithFade,
      duration: 300.milliseconds,
    ),

    CustomRoute(
      page: HomeRoute.page,
      path: '/home',
      // initial: true,
      guards: [
        Authguard(
          localstorage: getIt<Localstorage>(),
          authservice: getIt<Authservice>(),
        ),
      ],
      children: [
        CustomRoute(
          page: HomeTabRoute.page,
          duration: 300.milliseconds,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          path: '',
        ),
        CustomRoute(
          page: ProfileRoute.page,
          duration: 300.milliseconds,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          path: 'profile',
        ),
          CustomRoute(
          page: AddContactsRoute.page,
          duration: 300.milliseconds,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          path: 'add-contacts',
        ),
          CustomRoute(
          page: ShowQrRoute.page,
          duration: 300.milliseconds,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          path: 'show-qr',
        ),
          CustomRoute(
          page: SettingsRoute.page,
          duration: 300.milliseconds,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          path: 'settings',
        ),
        
      ],
      transitionsBuilder: TransitionsBuilders.slideRightWithFade,
      duration: 300.milliseconds,
    ),
  ];
}
