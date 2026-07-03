import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/utils/app_haptics.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/models/recent_read_entry.dart';
import 'package:frontend/widgets/cover_preview.dart';
import 'package:frontend/widgets/scale_on_press.dart';
import 'package:intl/intl.dart';

class RecentlyReadSection extends StatelessWidget {
  const RecentlyReadSection({
    super.key,
    required this.items,
    required this.ebooksById,
    required this.onOpen,
    required this.onContinue,
  });

  final List<RecentReadItem> items;
  final Map<int, Ebook> ebooksById;
  final void Function(Ebook ebook) onOpen;
  final void Function(Ebook ebook) onContinue;

  @override
  Widget build(BuildContext context) {
    final books = items
        .map((item) => (item, ebooksById[item.ebookId]))
        .where((pair) => pair.$2 != null)
        .toList();

    if (books.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm + 4),
          child: Row(
            children: [
              Text(
                'Continue Reading',
                style: theme.textTheme.titleMedium,
              ),
              const Spacer(),
              Icon(Icons.play_circle_outline_rounded, size: 20, color: AppColors.accent),
            ],
          ),
        ),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
            itemCount: books.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = books[index].$1;
              final ebook = books[index].$2!;
              return _RecentlyReadCard(
                ebook: ebook,
                item: item,
                onTap: () {
                  AppHaptics.light();
                  onContinue(ebook);
                },
                onOpenDetails: () => onOpen(ebook),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RecentlyReadCard extends StatelessWidget {
  const _RecentlyReadCard({
    required this.ebook,
    required this.item,
    required this.onTap,
    required this.onOpenDetails,
  });

  final Ebook ebook;
  final RecentReadItem item;
  final VoidCallback onTap;
  final VoidCallback onOpenDetails;

  String get _timeLabel {
    final now = DateTime.now();
    final diff = now.difference(item.readAt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat.MMMd().format(item.readAt);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaleOnPress(
      onTap: onTap,
      child: SizedBox(
        width: 132,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.secondary.withValues(alpha: 0.45)),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CoverPreview(
                        title: ebook.title,
                        subtitle: ebook.fileTypeLabel,
                        coverUrl: ebook.coverUrl,
                        compact: true,
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ClipRRect(
                          child: LinearProgressIndicator(
                            value: item.progress.clamp(0.0, 1.0),
                            minHeight: 3,
                            backgroundColor: Colors.black26,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ebook.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${item.progressPercent}% · $_timeLabel',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
                            ),
                          ),
                          GestureDetector(
                            onTap: onOpenDetails,
                            child: const Icon(
                              Icons.info_outline_rounded,
                              size: 15,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
