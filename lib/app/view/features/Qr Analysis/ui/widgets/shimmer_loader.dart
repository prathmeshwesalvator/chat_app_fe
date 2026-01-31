import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final ColorScheme colorScheme;

  const ShimmerLoader({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final isDark = colorScheme.brightness == Brightness.dark;

    final baseColor = isDark
        ? colorScheme.onSurface.withOpacity(0.12)
        : colorScheme.onSurface.withOpacity(0.08);

    final highlightColor = isDark
        ? colorScheme.onSurface.withOpacity(0.24)
        : colorScheme.onSurface.withOpacity(0.16);

    final skeletonColor = isDark
        ? colorScheme.onSurface.withOpacity(0.20)
        : colorScheme.onSurface.withOpacity(0.12);

    return Center(
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Card(
          elevation: 6,
          shadowColor: colorScheme.primary.withOpacity(.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Avatar skeleton
                Container(
                  height: 96,
                  width: 96,
                  decoration: BoxDecoration(
                    color: skeletonColor,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(height: 16),

                _line(width: 120, color: skeletonColor),
                const SizedBox(height: 6),
                _line(width: 180, color: skeletonColor),

                const SizedBox(height: 24),

                /// QR skeleton
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: skeletonColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
