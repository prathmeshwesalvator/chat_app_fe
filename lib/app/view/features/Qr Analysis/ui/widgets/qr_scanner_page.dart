import 'dart:ui';
import 'package:chat_app_fe/app/global/utils/haptic_feedback.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_bloc.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/ui/bloc/qr_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> with TickerProviderStateMixin {
  final MobileScannerController controller = MobileScannerController();
  bool isScanned = false;
  late AnimationController _scanLineController;
  late Animation<double> _scanLineAnimation;

  @override
  void initState() {
    super.initState();
    _scanLineController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _scanLineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scanLineController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scanLineController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const Icon(
                  CupertinoIcons.xmark,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onPressed: () {
            context.hapticLight();
            Navigator.pop(context);
          },
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: const Text(
                'Scan QR Code',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Camera View
          MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              if (isScanned) return;
              if (capture.barcodes.isNotEmpty) {
                final code = capture.barcodes.first.rawValue ?? '';
                if (code.isNotEmpty) {
                  isScanned = true;
                  HapticFeedback.mediumImpact();

                  context
                      .read<QrBloc>()
                      .add(GetUserInfo(body: {'contactHash': code}));
                  await controller.stop();

                  if (mounted) {
                    Navigator.pop(context, code);
                  }
                }
              }
            },
          ),

          // Overlay with scanning frame
          CustomPaint(
            painter: _ScannerOverlayPainter(
              scanLineAnimation: _scanLineAnimation,
              primaryColor: colorScheme.primary,
            ),
            child: Container(),
          ),

          // Instructions at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 80,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.qrcode_viewfinder,
                              color: colorScheme.primary,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            const Flexible(
                              child: Text(
                                'Position QR code within frame',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Torch button
          Positioned(
            right: 24,
            bottom: 24,
            child: _TorchButton(controller: controller),
          ),
        ],
      ),
    );
  }
}

class _TorchButton extends StatefulWidget {
  final MobileScannerController controller;

  const _TorchButton({required this.controller});

  @override
  State<_TorchButton> createState() => _TorchButtonState();
}

class _TorchButtonState extends State<_TorchButton> {
  bool _isTorchOn = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () async {
        context.hapticLight();
        await widget.controller.toggleTorch();
        setState(() => _isTorchOn = !_isTorchOn);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isTorchOn
                  ? colorScheme.primary.withOpacity(0.3)
                  : Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isTorchOn
                    ? colorScheme.primary.withOpacity(0.5)
                    : Colors.white.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Icon(
              _isTorchOn ? CupertinoIcons.bolt_fill : CupertinoIcons.bolt,
              color: _isTorchOn ? colorScheme.primary : Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final Animation<double> scanLineAnimation;
  final Color primaryColor;

  _ScannerOverlayPainter({
    required this.scanLineAnimation,
    required this.primaryColor,
  }) : super(repaint: scanLineAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final scanAreaSize = size.width * 0.7;
    final left = (size.width - scanAreaSize) / 2;
    final top = (size.height - scanAreaSize) / 2;
    final scanRect = Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize);

    // Draw overlay
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(scanRect, const Radius.circular(24)),
          ),
      ),
      overlayPaint,
    );

    // Draw corner brackets
    final cornerPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final cornerLength = 30.0;

    // Top-left
    canvas.drawLine(
      Offset(left, top + cornerLength),
      Offset(left, top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left, top),
      Offset(left + cornerLength, top),
      cornerPaint,
    );

    // Top-right
    canvas.drawLine(
      Offset(left + scanAreaSize - cornerLength, top),
      Offset(left + scanAreaSize, top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + scanAreaSize, top),
      Offset(left + scanAreaSize, top + cornerLength),
      cornerPaint,
    );

    // Bottom-left
    canvas.drawLine(
      Offset(left, top + scanAreaSize - cornerLength),
      Offset(left, top + scanAreaSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left, top + scanAreaSize),
      Offset(left + cornerLength, top + scanAreaSize),
      cornerPaint,
    );

    // Bottom-right
    canvas.drawLine(
      Offset(left + scanAreaSize - cornerLength, top + scanAreaSize),
      Offset(left + scanAreaSize, top + scanAreaSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + scanAreaSize, top + scanAreaSize - cornerLength),
      Offset(left + scanAreaSize, top + scanAreaSize),
      cornerPaint,
    );

    // Animated scan line
    final scanLinePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          primaryColor.withOpacity(0.0),
          primaryColor,
          primaryColor.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(left, top, scanAreaSize, 2));

    final scanLineY = top + (scanAreaSize * scanLineAnimation.value);
    canvas.drawLine(
      Offset(left, scanLineY),
      Offset(left + scanAreaSize, scanLineY),
      scanLinePaint..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}