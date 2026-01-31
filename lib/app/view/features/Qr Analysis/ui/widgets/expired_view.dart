import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget expiredView(BuildContext context) {
  return Column(
    key: const ValueKey('expired'),
    children: [
      const Icon(Icons.qr_code_2, size: 120, color: Colors.grey),
      const SizedBox(height: 10),
      const Text(
        'This QR has expired',
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
      const SizedBox(height: 16),
      ElevatedButton.icon(
        onPressed: () {
          context.read<QrBloc>().add(GenerateHash());
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Regenerate QR'),
      ),
    ],
  );
}
