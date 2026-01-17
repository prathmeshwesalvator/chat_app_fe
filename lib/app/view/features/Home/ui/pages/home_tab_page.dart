import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/custom_side_bar.dart';
import 'package:flutter/material.dart';


@RoutePage()
class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return const CustomSideBar();
  }
}