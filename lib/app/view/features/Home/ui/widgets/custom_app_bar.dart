import 'package:chat_app_fe/app/core/networking/api_extensions.dart';
import 'package:chat_app_fe/app/global/shared_widgets/circular_logo.dart';
import 'package:chat_app_fe/app/global/utils/device_identification.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const CircularLogo(
        size: 80,
        pulseAnimation: true,
        pulseDuration: Duration(milliseconds: 300),
      ),
      actions: [
        isDesktop(context)
            ? InkWell(
                onTap: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              )
            : PopupMenuButton(
                color: Theme.of(context).colorScheme.surface,
                elevation: 5,
                style: ButtonStyle(animationDuration: 5.milliseconds),
                icon: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: drawerTile(
                      context,
                      icon: Icons.nightlight,
                      title: 'Theme',
                      onTap: () {},
                    ),
                  ),
                  PopupMenuItem(
                    child: drawerTile(
                      context,
                      icon: Icons.logout_outlined,
                      title: 'Log Out',
                      onTap: () {},
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
      ],
      elevation: 5,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
