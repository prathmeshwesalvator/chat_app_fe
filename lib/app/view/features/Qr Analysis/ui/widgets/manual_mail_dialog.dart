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
          return AlertDialog(
            title: const Text("Enter Email"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🔹 EMAIL INPUT
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "example@mail.com",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Enter email";
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 16),

                /// 🔹 USER PREVIEW SECTION
                if (showUserSection)
                  BlocBuilder<QrBloc, QrState>(
                    builder: (context, state) {
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

                      if (state.userInfoStatus == Blocstatus.success &&
                          state.userInfo != null) {
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
                    },
                  ),
              ],
            ),
            actions: [
              /// 🔹 CANCEL
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),

              /// 🔹 SHOW USER BUTTON
              if (!showUserSection)
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      /// Fire fetch user event (NOT add contact)
                      context.read<QrBloc>().add(
                            GetUserInfo(body: {'mailId': controller.text}),
                          );

                      setState(() {
                        showUserSection = true;
                      });
                    }
                  },
                  child: const Text("Show User"),
                ),

              /// 🔹 ADD CONTACT BUTTON
              if (showUserSection)
                ElevatedButton(
                  onPressed: () {
                    final body = {'mailId': controller.text};

                    context.read<QrBloc>().add(AddContact(body: body));

                    Navigator.pop(context);
                  },
                  child: const Text("Add Contact"),
                ),
            ],
          );
        },
      );
    },
  );
}
