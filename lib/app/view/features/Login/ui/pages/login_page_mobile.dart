import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_cubit.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/bloc/login_state.dart';
import 'package:chat_app_fe/app/view/features/Login/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPageMobile extends StatefulWidget {
  const LoginPageMobile({super.key});

  @override
  State<LoginPageMobile> createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.loginStatus == Blocstatus.success) {
            context.router.replaceAll([const AppShellRoute()]);
          }

          if (state.loginStatus == Blocstatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: colors.error,
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary, colors.primaryContainer],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          /// TOP SPACING
                          const SizedBox(height: 48),

                          /// APP TITLE
                          Text(
                            'ChatSphere',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: colors.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Private • Fast • Secure',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onPrimary.withOpacity(0.75),
                            ),
                          ),

                          const Spacer(),

                          /// FORM CARD
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(28),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 20,
                                  offset: const Offset(0, -4),
                                ),
                              ],
                            ),
                            child: LoginForm(
                              formKey: _formKey,
                              usernameController: _usernameController,
                              passwordController: _passwordController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
