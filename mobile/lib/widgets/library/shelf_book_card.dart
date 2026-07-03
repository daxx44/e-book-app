import 'package:flutter/material.dart';
import 'package:frontend/core/theme/library_shelf_theme.dart';
import 'package:frontend/core/utils/app_haptics.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/widgets/book_options_menu.dart';
import 'package:frontend/widgets/cover_preview.dart';
import 'package:frontend/widgets/scale_on_press.dart';

class ShelfBookCard extends StatelessWidget {
  const ShelfBookCard({
    super.key,
    required this.ebook,
    required this.onTap,
    required this.onRead,
    required this.onDownload,
    required this.onDelete,
    this.height = 196,
  });

  final Ebook ebook;
  final VoidCallback onTap;
  final VoidCallback onRead;
  final VoidCallback onDownload;
  final VoidCallback onDelete;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaleOnPress(
      onTap: () {
        AppHaptics.light();
        onTap();
      },
      child: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(4),
                            right: Radius.circular(2),
                          ),
                          child: CoverPreview(
                            title: ebook.title,
                            subtitle: ebook.fileTypeLabel,
                            coverUrl: ebook.coverUrl,
                            compact: true,
                            showFormatBadge: false,
                          ),
                        ),
                        Positioned(
                          left: 6,
                          bottom: 6,
                          right: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ebook.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  shadows: const [
                                    Shadow(color: Colors.black54, blurRadius: 6),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                ebook.displayAuthor,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.88),
                                  shadows: const [
                                    Shadow(color: Colors.black45, blurRadius: 4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: _FormatBadge(label: ebook.fileTypeLabel),
                        ),
                        Positioned(
                          top: 5,
                          left: 5,
                          child: BookOptionsMenu(
                            lightStyle: true,
                            onRead: onRead,
                            onDownload: onDownload,
                            onDelete: onDelete,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 5,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black.withValues(alpha: 0.35),
                          Colors.black.withValues(alpha: 0.65),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormatBadge extends StatelessWidget {
  const _FormatBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: LibraryShelfTheme.headerText,
                fontWeight: FontWeight.w700,
                fontSize: 9,
              ),
        ),
      ),
    );
  }
}
