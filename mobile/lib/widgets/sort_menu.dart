import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/library_shelf_theme.dart';

class SortMenu extends StatelessWidget {
  const SortMenu({
    super.key,
    required this.value,
    required this.onChanged,
    this.iconOnly = false,
    this.dark = false,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final bool iconOnly;
  final bool dark;

  static const options = <String, String>{
    'recent': 'Recently added',
    'title': 'Title A–Z',
    'author': 'Author A–Z',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = dark ? LibraryShelfTheme.headerText : AppColors.textPrimary;
    final bg = dark ? Colors.white.withValues(alpha: 0.08) : AppColors.background;
    final border = dark ? Colors.white.withValues(alpha: 0.12) : AppColors.secondary.withValues(alpha: 0.55);

    return PopupMenuButton<String>(
      tooltip: 'Sort library',
      initialValue: value,
      onSelected: onChanged,
      offset: const Offset(0, 44),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
      child: iconOnly
          ? SizedBox(
              width: 42,
              height: 42,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: border),
                ),
                child: Icon(Icons.tune_rounded, size: 22, color: fg),
              ),
            )
          : Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.swap_vert_rounded, size: 20, color: fg),
                  const SizedBox(width: 6),
                  Text(
                    'Sort',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: fg,
                    ),
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
