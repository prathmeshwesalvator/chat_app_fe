import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/manual_mail_dialog.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/qr-scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> openDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Choose Option'),
        content: const Text('Select how you want to continue.'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const QrScannerPage(),
                ),
              );

              if (result != null && context.mounted) {
                addingResultPopup(
                  context,
                  "You are adding",
                  result.toString(),
                );
              }
            },
            child: const Text('Scan QR with Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              showMailEntryDialog(context);
            },
            child: const Text('Enter mail manually'),
          ),
        ],
      );
    },
  );
}



Future<void> showResultPopup(
  BuildContext context,
  String title,
  String value,
) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: SelectableText(value),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}



Future<void> addingResultPopup(
  BuildContext context,
  String title,
  String value,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return BlocConsumer<QrBloc, QrState>(
        listenWhen: (p, c) => p.addContactStatus != c.addContactStatus,
        listener: (context, state) {
          if (state.addContactStatus == Blocstatus.success) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {

          /// LOADING USER INFO
          if (state.userInfoStatus == Blocstatus.loading) {
            return const AlertDialog(
              content: SizedBox(
                height: 80,
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          /// ERROR
          if (state.userInfoStatus == Blocstatus.error) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(state.errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          }

          /// SUCCESS USER FETCH
          if (state.userInfoStatus == Blocstatus.success &&
              state.userInfo != null) {

            final user = state.userInfo!;
            final isAdding = state.addContactStatus == Blocstatus.loading;

            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.username,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text(user.fullName),
                  const SizedBox(height: 6),
                  Text(user.email),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isAdding ? null : () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: isAdding
                      ? null
                      : () {
                          context.read<QrBloc>().add(
                                AddContact(body: {'contactHash': value}),
                              );
                        },
                  child: isAdding
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Add"),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      );
    },
  );
}
