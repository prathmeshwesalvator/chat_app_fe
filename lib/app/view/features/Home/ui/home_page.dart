import 'package:auto_route/annotations.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_cubit.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_state.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/widgets/custom_app_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: Drawer(
        
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.profileStatus == Blocstatus.error) {
            return Center(
              child: Text('An Error Occurred ${state.errorMessage}'),
            );
          }

          if (state.profileStatus == Blocstatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.profileStatus == Blocstatus.success) {
            return Text('state is success');
          }

          return const SizedBox();
        },
      ),
    );
  }
}
