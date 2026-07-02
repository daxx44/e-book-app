import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/utils/app_haptics.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/widgets/cover_preview.dart';
import 'package:frontend/widgets/highlighted_text.dart';
import 'package:frontend/widgets/scale_on_press.dart';

enum BookCardAction { read, download, delete }

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.ebook,
    required this.onTap,
    required this.onDownload,
    required this.onDelete,
    this.onRead,
    this.highlightQuery = '',
    this.compact = false,
  });

  final Ebook ebook;
  final VoidCallback onTap;
  final VoidCallback onDownload;
  final VoidCallback onDelete;
  final VoidCallback? onRead;
  final String highlightQuery;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${ebook.title} by ${ebook.displayAuthor}',
      button: true,
      child: ScaleOnPress(
        onTap: () {
          AppHaptics.light();
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        child: CoverPreview(
                          title: ebook.title,
                          subtitle: ebook.fileTypeLabel,
                          heroTag: 'book-cover-${ebook.id}',
                          compact: true,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: _BookMenuButton(
                        onSelected: (action) {
                          AppHaptics.selection();
                          switch (action) {
                            case BookCardAction.read:
                              (onRead ?? onTap)();
                            case BookCardAction.download:
                              onDownload();
                            case BookCardAction.delete:
                              onDelete();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 2, right: 2, bottom: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HighlightedText(
                      text: ebook.title,
                      query: highlightQuery,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    HighlightedText(
                      text: ebook.displayAuthor,
                      query: highlightQuery,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _metadataLine,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _metadataLine {
    final parts = [ebook.fileTypeLabel, ebook.formattedUploadDate];
    if (ebook.fileSize != null && ebook.fileSize! > 0) {
      parts.add(ebook.formattedFileSize);
    }
    return parts.join(' · ');
  }
}

class _BookMenuButton extends StatelessWidget {
  const _BookMenuButton({required this.onSelected});

  final ValueChanged<BookCardAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.94),
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      shadowColor: Colors.black26,
      child: PopupMenuButton<BookCardAction>(
        icon: const Icon(Icons.more_horiz_rounded, size: 20, color: AppColors.textPrimary),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: onSelected,
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: BookCardAction.read,
            child: ListTile(
              leading: Icon(Icons.menu_book_outlined),
              title: Text('Read'),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
          PopupMenuItem(
            value: BookCardAction.download,
            child: ListTile(
              leading: Icon(Icons.download_outlined),
              title: Text('Download'),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
          PopupMenuItem(
            value: BookCardAction.delete,
            child: ListTile(
              leading: Icon(Icons.delete_outline, color: AppColors.error),
              title: Text('Delete', style: TextStyle(color: AppColors.error)),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
        ],
      ),
    );
  }
}
