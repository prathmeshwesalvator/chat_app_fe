import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/manual_mail_dialog.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/widgets/qr-scanner_page.dart';
import 'package:flutter/material.dart';

Future<void> openDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
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

              if (result != null) {
                await showResultPopup(
                  context,
                  "You are adding ",
                  result.toString(),
                );
              }
            },
            child: const Text('Scan QR with Camera'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              final email = await showMailEntryDialog(context);

              if (email != null) {
                await showResultPopup(
                  context,
                  "Entered Email",
                  email,
                );
              }
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
