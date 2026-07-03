import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/utils/app_haptics.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/widgets/cover_preview.dart';
import 'package:frontend/widgets/primary_button.dart';

Future<void> showBookDetailsSheet(
  BuildContext context, {
  required Ebook ebook,
  required VoidCallback onRead,
  required VoidCallback onDownload,
  required VoidCallback onDelete,
}) async {
  AppHaptics.light();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.72,
        minChildSize: 0.45,
        maxChildSize: 0.92,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
              boxShadow: [
                BoxShadow(color: Color(0x33000000), blurRadius: 24, offset: Offset(0, -4)),
              ],
            ),
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                MediaQuery.paddingOf(context).bottom + AppSpacing.lg,
              ),
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
                Center(
                  child: SizedBox(
                    width: 140,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      child: CoverPreview(
                        title: ebook.title,
                        subtitle: ebook.fileTypeLabel,
                        coverUrl: ebook.coverUrl,
                        heroTag: 'book-cover-${ebook.id}',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(ebook.title, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  ebook.displayAuthor,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                if (ebook.description?.isNotEmpty == true) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(ebook.description!, style: Theme.of(context).textTheme.bodyMedium),
                ],
                const SizedBox(height: AppSpacing.lg),
                _MetaRow(label: 'Format', value: ebook.fileTypeLabel),
                _MetaRow(label: 'Size', value: ebook.formattedFileSize),
                _MetaRow(label: 'Uploaded', value: ebook.formattedUploadDate),
                if (ebook.filename != null) _MetaRow(label: 'File', value: ebook.filename!),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: 'Read now',
                  icon: Icons.menu_book_rounded,
                  onPressed: () {
                    Navigator.pop(context);
                    AppHaptics.medium();
                    onRead();
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    onDownload();
                  },
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Download'),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    onDelete();
                  },
                  icon: const Icon(Icons.delete_outline, color: AppColors.error),
                  label: const Text('Delete from library', style: TextStyle(color: AppColors.error)),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 88, child: Text(label, style: Theme.of(context).textTheme.labelMedium)),
          Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
