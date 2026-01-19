import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/global/utils/device_identification.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppBarMenu { theme, logout }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 1,
      backgroundColor: theme.colorScheme.primary,

      title: Text(
        'Chat Sphere',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),

      actions: [
        /// Desktop Avatar → Drawer
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
        /// Mobile Popup Menu
        else
          PopupMenuButton<AppBarMenu>(
            icon: CircleAvatar(
              backgroundColor: theme.colorScheme.surface,
              child: Icon(
                Icons.person_outline,
                color: theme.colorScheme.primary,
              ),
            ),

            onSelected: (value) {
              switch (value) {
                case AppBarMenu.theme:
                  // TODO: Toggle theme
                  break;

                case AppBarMenu.logout:
                  context.read<HomeCubit>().logOutUser();

                  /// Delay navigation until menu closes
                  Future.microtask(() {
                    context.router.replace(const LoginRoute());
                  });
                  break;
              }
            },

            itemBuilder: (_) => [
              const PopupMenuItem(
                value: AppBarMenu.theme,
                child: Row(
                  children: [
                    Icon(Icons.nightlight),
                    SizedBox(width: 10),
                    Text('Theme'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: AppBarMenu.logout,
                child: Row(
                  children: [
                    Icon(Icons.logout_outlined, color: Colors.red),
                    SizedBox(width: 10),
                    Text('Log Out', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),

        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
