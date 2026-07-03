import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/reader_theme.dart';

Future<void> showReaderSettingsSheet(
  BuildContext context, {
  required double fontSize,
  required Future<void> Function(double) onFontSizeChanged,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
    ),
    builder: (context) {
      var localFontSize = fontSize;

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              MediaQuery.paddingOf(context).bottom + AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text('Reading settings', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Text('Font size', style: Theme.of(context).textTheme.titleSmall),
                    const Spacer(),
                    Text(
                      '${localFontSize.round()} pt',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Slider(
                  value: localFontSize,
                  min: 14,
                  max: 22,
                  divisions: 8,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() => localFontSize = value);
                    onFontSizeChanged(value);
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Preview',
                  style: ReaderTheme.chapterLabelStyle,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'The true essence of a private study lies not in its size, but in the quality of thought it inspires.',
                  style: ReaderTheme.bodySerif(localFontSize),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
