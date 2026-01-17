import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/global/utils/device_identification.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_cubit.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/custom_app_bar.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/custom_bottom_nav.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/custom_drawer.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/custom_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeTabRoute(),
        ProfileRoute(),
        AddContactsRoute(),
        ShowQrRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          key: scaffoldKey,
          appBar: CustomAppBar(scaffoldKey: scaffoldKey),

          endDrawer: isDesktop(context) ? const CustomDrawer() : null,

          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isDesktop(context)
                  ? Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: CustomSideBar()),
                        Expanded(flex: 2, child: child),
                      ],
                    )
                  : child,
            ),
          ),

          bottomNavigationBar: isDesktop(context)
              ? null
              : CustomBottomNav(tabsRouter: tabsRouter),
        );
      },
    );
  }
}
