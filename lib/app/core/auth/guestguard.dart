import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/core/localstorage/localstorage.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';

class Guestguard extends AutoRouteGuard {
  const Guestguard({required this.localstorage});

  final Localstorage localstorage;
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final token = await localstorage.getToken();

    if (token.isEmpty) {
      return resolver.next();
    } else {
      router.push(const AppShellRoute());
    }
  }
}
