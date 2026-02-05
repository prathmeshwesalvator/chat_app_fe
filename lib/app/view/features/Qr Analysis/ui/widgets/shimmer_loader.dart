import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final ColorScheme colorScheme;

  const ShimmerLoader({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final isDark = colorScheme.brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor =
        isDark ? Colors.grey.shade700 : Colors.grey.shade100;
    final skeletonColor =
        isDark ? Colors.grey.shade700 : Colors.grey.shade400;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent, // 🔥 IMPORTANT
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Avatar
            _shimmer(
              baseColor,
              highlightColor,
              Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Username
            _shimmer(
              baseColor,
              highlightColor,
              _line(width: 100, color: skeletonColor),
            ),

            const SizedBox(height: 8),

            /// Subtitle
            _shimmer(
              baseColor,
              highlightColor,
              _line(width: 180, color: skeletonColor),
            ),

            const SizedBox(height: 24),

            /// QR Code
            _shimmer(
              baseColor,
              highlightColor,
              Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Scan text
            _shimmer(
              baseColor,
              highlightColor,
              _line(width: 200, color: skeletonColor),
            ),

            const SizedBox(height: 20),

            /// Divider
            _shimmer(
              baseColor,
              highlightColor,
              Container(
                height: 1,
                width: double.infinity,
                color: skeletonColor,
              ),
            ),

            const SizedBox(height: 16),

            /// Expiry Row
            _shimmer(
              baseColor,
              highlightColor,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: skeletonColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _line(width: 90, color: skeletonColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmer(Color base, Color highlight, Widget child) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: child,
    );
  }

  Widget _line({required double width, required Color color}) {
    return Container(
      height: 12,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
