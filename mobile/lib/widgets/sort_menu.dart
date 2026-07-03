import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';

class SortMenu extends StatelessWidget {
  const SortMenu({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  static const options = <String, String>{
    'recent': 'Recently added',
    'title': 'Title A–Z',
    'author': 'Author A–Z',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopupMenuButton<String>(
      tooltip: 'Sort library',
      initialValue: value,
      onSelected: onChanged,
      offset: const Offset(0, 44),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.secondary.withValues(alpha: 0.55)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.swap_vert_rounded, size: 20, color: AppColors.textPrimary),
            const SizedBox(width: 6),
            Text(
              'Sort',
              style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => options.entries
          .map(
            (entry) => PopupMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: entry.key == value
                        ? const Icon(Icons.check_rounded, size: 18, color: AppColors.accent)
                        : null,
                  ),
                  Text(entry.value),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
