import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController controller = MobileScannerController();
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR')),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) async {
          if (isScanned) return; // ⭐ prevent multiple triggers

          if (capture.barcodes.isNotEmpty) {
            final code = capture.barcodes.first.rawValue ?? '';

            if (code.isNotEmpty) {
              isScanned = true;

              context
                  .read<QrBloc>()
                  .add(GetUserInfo(body: {'contactHash': code}));

              await controller.stop(); // ⭐ stop camera stream

              if (mounted) {
                Navigator.pop(context, code);
              }
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
