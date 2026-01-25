import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/utils/device_identification.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/pages/login_page_desktop.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/pages/login_page_mobile.dart';
import 'package:flutter/material.dart';


@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return isDesktop(context) || isTablet(context)
        ? const LoginPageDesktop()
        : const LoginPageMobile();
  }
}
