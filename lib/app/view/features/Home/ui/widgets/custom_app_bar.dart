import 'package:chat_app_fe/app/global/shared_widgets/circular_logo.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircularLogo(
            size: 50,
            animate: true,
            animationDuration: Duration(milliseconds: 300),
          ),
          Text('Chat Sphere' , 
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.shadow
          )),
        ],
      ),
      elevation: 5,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
