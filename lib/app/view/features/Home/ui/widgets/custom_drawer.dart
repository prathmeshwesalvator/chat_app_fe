import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/global/utils/conversion_methods.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_cubit.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          Expanded(child: _buildHeader(theme, context)),

          // ---------------- MENU ITEMS ----------------
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                drawerTile(
                  context,
                  icon: Icons.home_outlined,
                  title: 'Home',
                  onTap: () {},
                ),
                drawerTile(
                  context,
                  icon: Icons.person_outline,
                  title: 'Profile',
                  onTap: () {},
                ),
                drawerTile(
                  context,
                  icon: Icons.add_box_rounded,
                  title: 'Add Contact',
                  onTap: () {},
                ),
                drawerTile(
                  context,
                  icon: Icons.qr_code_2_outlined,
                  title: 'Show QR',
                  onTap: () {},
                ),
                drawerTile(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {},
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Joined By : ${ConversionMethods.formatDate(context.read<HomeCubit>().state.dateJoined)}',
                style: theme.textTheme.bodySmall!.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const Divider(height: 1),

          // ---------------- LOGOUT ----------------
          drawerTile(
            context,
            icon: Icons.logout,
            title: 'Logout',
            color: Colors.red,
            onTap: () {
              if (context.read<HomeCubit>().state.logOutStatus ==
                  Blocstatus.loading) {
                return;
              }

              context.read<HomeCubit>().logOutUser();
              context.router.push(HomeRoute());
            },
          ),
        ],
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader(ThemeData theme, BuildContext context) {
    final state = context.read<HomeCubit>().state;

    return DrawerHeader(
      decoration: BoxDecoration(color: theme.colorScheme.primary),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: theme.colorScheme.secondary,
              child: Text(
                state.username[0].toUpperCase(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.username.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
