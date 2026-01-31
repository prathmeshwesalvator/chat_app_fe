 import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_state.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget qrView(BuildContext context, QrState state) {
    return Column(
      key: const ValueKey('qr'),
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: QrImageView(
            data: state.qrData?.contactHash ?? '',
            padding: const EdgeInsets.all(16),
            eyeStyle: QrEyeStyle(
              color: Theme.of(context).colorScheme.primary,
              eyeShape: QrEyeShape.square,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Scan to add me in your contacts',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

