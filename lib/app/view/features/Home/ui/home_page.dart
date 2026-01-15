import 'package:auto_route/annotations.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/utils/custom_dock_with_offset.dart';
import 'package:chat_app_fe/app/global/utils/device_identification.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_cubit.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_state.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/custom_app_bar.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/custom_bottom_nav.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/custom_drawer.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/home_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadUserProfile();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),

      endDrawer: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.username.isEmpty
              ? const SizedBox()
              : const CustomDrawer();
        },
      ),

      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (prev, curr) => prev.profileStatus != curr.profileStatus,
        builder: (context, state) {
          if (state.profileStatus == Blocstatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.profileStatus == Blocstatus.error) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          if (state.profileStatus == Blocstatus.success) {
            return const HomePageBody();
          }

          return const SizedBox.shrink();
        },
      ),

      floatingActionButton: isMobile(context)
          ? FloatingActionButton(
              onPressed: () {},
              tooltip: 'Add Contact',
              elevation: 8,
              child: const Icon(Icons.add_outlined),
            )
          : null,

      floatingActionButtonLocation: const CenterDockedWithOffset(-8),

      bottomNavigationBar: isMobile(context) ? const CustomBottomNav() : null,
    );
  }
}
