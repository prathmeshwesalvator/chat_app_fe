import 'package:flutter/material.dart';

Widget drawerTile(
  BuildContext context, {
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  Color? color,
}) {
  final theme = Theme.of(context);

  return ListTile(
    leading: Icon(icon, size: 28, color: color ?? theme.colorScheme.primary),
    title: Text(
      title,
      style: theme.textTheme.titleMedium!.copyWith(
        color: color ?? theme.colorScheme.primary,
      ),
    ),
    onTap: onTap,
  );
}



Widget bottomNavTile(
  BuildContext context, {
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  bool isCenter = false,
  Color? color,
}) {
  final theme = Theme.of(context);

  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Column(
      children: [
        if (isCenter)
          Container(
            height: MediaQuery.sizeOf(context).width * 0.20,
            width: MediaQuery.sizeOf(context).height * 0.20,
            decoration: BoxDecoration(
              color: color ?? theme.colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
          )
        else
          Icon(
            icon,
            color: color ?? theme.colorScheme.primary,
            size: 24,
          ),
        const SizedBox(height: 4),
        if (!isCenter)
          Text(
            title,
            style: theme.textTheme.labelSmall!.copyWith(
              color: color ?? theme.colorScheme.primary,
            ),
          ),
      ],
    ),
  );
}
