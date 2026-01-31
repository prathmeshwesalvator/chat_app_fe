import 'package:chat_app_fe/app/core/di/setupLocator.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/global/theme/app_theme.dart';
import 'package:chat_app_fe/app/view/features/Home/domain/usecases/home_usecases.dart';
import 'package:chat_app_fe/app/view/features/Home/ui/bloc/home_cubit.dart';
import 'package:chat_app_fe/app/view/features/Login/domain/usecases/login_usecases.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_cubit.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/domain/usecases/qr_usecases.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/usecases/contact_usecases.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.asNewInstance();
final appRoute = AppRoute();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator(getIt);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(homeUsecases: getIt<HomeUsecases>()),
        ),
        BlocProvider(create: (_) => LoginCubit(loginUsecases: getIt<LoginUsecases>())),
        BlocProvider(create: (_) => ContactsBloc(contactUsecases: getIt<ContactUsecases>())),
        BlocProvider(create: (_) => QrBloc(qrUsecases: getIt<QrUsecases>()))
      ],
      child: MaterialApp.router(
        // showPerformanceOverlay: true,
        title: 'Flutter Demo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: appRoute.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
