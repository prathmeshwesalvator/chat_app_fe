import 'package:chat_app_fe/app/global/shared_widgets/circular_logo.dart';
import 'package:chat_app_fe/app/global/utils/device_identification.dart';
import 'package:flutter/material.dart';

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
        InkWell(
          onTap: () {
            isDesktop(context)
                ? scaffoldKey.currentState?.openEndDrawer()
                : null;
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
        ),
      ],
      elevation: 5,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
