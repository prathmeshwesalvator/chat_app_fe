import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showMailEntryDialog(BuildContext context) async {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showUserSection = false;

  showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return BlocConsumer<QrBloc, QrState>(
            listenWhen: (p, c) => p.addContactStatus != c.addContactStatus,
            listener: (context, state) {
              if (state.addContactStatus == Blocstatus.success) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final isAdding = state.addContactStatus == Blocstatus.loading;

              return AlertDialog(
                title: const Text("Enter Email"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// EMAIL FIELD
                    Form(
                      key: formKey,
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(hintText: "example@mail.com"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter email";
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// USER PREVIEW
                    if (showUserSection) _MailUserPreview(state: state),
                  ],
                ),
                actions: [
                  /// CANCEL
                  TextButton(
                    onPressed: isAdding ? null : () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),

                  /// SHOW USER
                  if (!showUserSection)
                    ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;

                        context.read<QrBloc>().add(
                              GetUserInfo(
                                body: {'mailId': controller.text},
                              ),
                            );

                        setState(() => showUserSection = true);
                      },
                      child: const Text("Show User"),
                    ),

                  /// ADD CONTACT
                  if (showUserSection)
                    ElevatedButton(
                      onPressed: state.userInfoStatus == Blocstatus.success &&
                              !isAdding
                          ? () {
                              context.read<QrBloc>().add(
                                    AddContact(
                                      body: {'mailId': controller.text},
                                    ),
                                  );
                            }
                          : null,
                      child: isAdding
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Add Contact"),
                    ),
                ],
              );
            },
          );
        },
      );
    },
  );
}

class _MailUserPreview extends StatelessWidget {
  final QrState state;

  const _MailUserPreview({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.userInfoStatus == Blocstatus.loading) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: CircularProgressIndicator(),
      );
    }

    if (state.userInfoStatus == Blocstatus.error) {
      return Text(
        state.errorMessage,
        style: const TextStyle(color: Colors.red),
      );
    }

    if (state.userInfoStatus == Blocstatus.success && state.userInfo != null) {
      final user = state.userInfo!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Username: ${user.username}"),
          Text("Name: ${user.fullName}"),
          Text("Email: ${user.email}"),
        ],
      );
    }

    return const SizedBox();
  }
}
