import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/core/networking/api_extensions.dart';
import 'package:chat_app_fe/app/global/shared_widgets/circular_logo.dart';
import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key, required this.tabsRouter});

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.scaffoldBackgroundColor,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: Colors.grey.shade500,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedFontSize: 12,
        items: [
          _navItem(
            context,
            icon: Icons.home_rounded,
            label: 'Home',
            index: 0,
          ),
          _navItem(
            context,
            icon: Icons.contacts_outlined,
            label: 'Contacts',
            index: 1,
          ),

          BottomNavigationBarItem(
            label: 'Add',
            icon: CircularLogo(
              size: 64,
          
              icon: Icons.add_outlined,
              pulseAnimation: true,
              pulseDuration: 30.seconds,
              ) 
          ),


          _navItem(
            context,
            icon: Icons.qr_code_rounded,
            label: 'QR',
            index: 3,
          ),
          _navItem(
            context,
            icon: Icons.settings_rounded,
            label: 'Settings',
            index: 4,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isActive = tabsRouter.activeIndex == index;
    final color = isActive
        ? Theme.of(context).colorScheme.primary
        : Colors.grey.shade500;

    return BottomNavigationBarItem(
      label: label,
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color),
      ),
    );
  }

}
