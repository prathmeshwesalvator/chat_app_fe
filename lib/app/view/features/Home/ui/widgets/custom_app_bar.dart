import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/theme/bloc/theme_cubit.dart';
import 'package:chat_app_fe/app/global/utils/device_identification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

enum AppBarMenu { theme, logout }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.index,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarTitle = 'Chat Sphere';
    final actionList = <Widget>[
      if (isDesktop(context))
        IconButton(
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          onPressed: () {
            scaffoldKey.currentState?.openEndDrawer();
          },
        )
      else
        const SizedBox()
    ];

    switch (index) {
      case 0:
    }

    return AppBar(
      leading: Builder(
        builder: (context) {
          final canPop = context.router.canPop();

          if (canPop) {
            return const AutoLeadingButton();
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              context.read<ThemeCubit>().state.appTheme == ThemeMode.dark
                  ? 'assets/logo_icon_dark.svg'
                  : 'assets/logo_icon_light.svg',
            ),
          );
        },
      ),
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: theme.colorScheme.surface),
      elevation: 1,
      backgroundColor: theme.colorScheme.primary,
      title: Text(
        appBarTitle,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.surface,
            ),
      ),
      actions: actionList,
      actionsPadding: const EdgeInsets.all(8),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
