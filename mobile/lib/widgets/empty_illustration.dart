import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';

/// Decorative illustration for empty states — stacked books motif.
class EmptyIllustration extends StatelessWidget {
  const EmptyIllustration({super.key, this.icon = Icons.auto_stories_rounded});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 24,
            bottom: 20,
            child: _BookTile(
              colors: AppColors.coverGradients[2],
              rotation: -0.12,
              width: 56,
              height: 72,
            ),
          ),
          Positioned(
            right: 28,
            bottom: 16,
            child: _BookTile(
              colors: AppColors.coverGradients[4],
              rotation: 0.1,
              width: 52,
              height: 68,
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.22),
                  blurRadius: 28,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Icon(icon, size: 48, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  const _BookTile({
    required this.colors,
    required this.rotation,
    required this.width,
    required this.height,
  });

  final List<Color> colors;
  final double rotation;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: colors.first.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 6)),
          ],
        ),
      ),
    );
  }
}
