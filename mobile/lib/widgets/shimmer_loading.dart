import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/library_shelf_theme.dart';
import 'package:frontend/widgets/library/wooden_shelf_plank.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 16,
    this.baseColor,
    this.highlightColor,
  });

  final double width;
  final double height;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final base = baseColor ?? AppColors.shimmerBase;
    final highlight = highlightColor ?? AppColors.shimmerHighlight;

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Skeleton loader matching the wooden bookshelf library layout.
class LibraryShimmer extends StatelessWidget {
  const LibraryShimmer({super.key});

  static const _base = Color(0xFF241612);
  static const _highlight = Color(0xFF3D2B22);

  @override
  Widget build(BuildContext context) {
    final booksPerRow = MediaQuery.sizeOf(context).width >= 800 ? 4 : 3;
    final bookHeight = ShelfMetrics.bookHeightFor(context, booksPerRow);

    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 100),
      children: [
        _ContinueReadingStrip(),
        const SizedBox(height: 8),
        for (var row = 0; row < 2; row++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _ShelfRowShimmer(
              booksPerRow: booksPerRow,
              bookHeight: bookHeight,
            ),
          ),
      ],
    );
  }
}

class _ContinueReadingStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerBox(
            width: 140,
            height: 18,
            borderRadius: 6,
            baseColor: LibraryShimmer._base,
            highlightColor: LibraryShimmer._highlight,
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: ShelfMetrics.continueReadingStripHeight,
            child: Row(
              children: [
                Expanded(
                  child: _BookColumnShimmer(
                    bookHeight: ShelfMetrics.resolvedBookHeight(ShelfMetrics.continueBookWidth),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _BookColumnShimmer(
                    bookHeight: ShelfMetrics.resolvedBookHeight(ShelfMetrics.continueBookWidth),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShelfRowShimmer extends StatelessWidget {
  const _ShelfRowShimmer({
    required this.booksPerRow,
    required this.bookHeight,
  });

  final int booksPerRow;
  final double bookHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: ShelfMetrics.rowHorizontalPadding),
              child: _ShelfPlankShimmer(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                ShelfMetrics.rowHorizontalPadding,
                0,
                ShelfMetrics.rowHorizontalPadding,
                ShelfMetrics.bookRestInset,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var i = 0; i < booksPerRow; i++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ShelfMetrics.columnGap / 2,
                        ),
                        child: _BookColumnShimmer(bookHeight: bookHeight),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            ShelfMetrics.rowHorizontalPadding,
            4,
            ShelfMetrics.rowHorizontalPadding,
            0,
          ),
          child: Row(
            children: [
              for (var i = 0; i < booksPerRow; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ShelfMetrics.columnGap / 2,
                    ),
                    child: const _WallLabelShimmer(),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

class _BookColumnShimmer extends StatelessWidget {
  const _BookColumnShimmer({required this.bookHeight});

  final double bookHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final coverW = ShelfMetrics.bookWidthForColumn(constraints.maxWidth, bookHeight);
        final coverH = ShelfMetrics.resolvedBookHeight(coverW);
        const spineW = 5.0;
        const edgeW = 3.0;

        return Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ShimmerBox(
                width: spineW,
                height: coverH,
                borderRadius: 2,
                baseColor: LibraryShimmer._base,
                highlightColor: LibraryShimmer._highlight,
              ),
              ShimmerBox(
                width: coverW,
                height: coverH,
                borderRadius: 3,
                baseColor: LibraryShimmer._base,
                highlightColor: LibraryShimmer._highlight,
              ),
              ShimmerBox(
                width: edgeW,
                height: coverH,
                borderRadius: 1,
                baseColor: LibraryShimmer._base,
                highlightColor: LibraryShimmer._highlight,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ShelfPlankShimmer extends StatelessWidget {
  const _ShelfPlankShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerBox(
          width: double.infinity,
          height: ShelfMetrics.totalShelfHeight,
          borderRadius: 4,
          baseColor: LibraryShelfTheme.shelfShadow.withValues(alpha: 0.55),
          highlightColor: LibraryShelfTheme.shelfMid.withValues(alpha: 0.75),
        ),
      ],
    );
  }
}

class _WallLabelShimmer extends StatelessWidget {
  const _WallLabelShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ShimmerBox(
          width: double.infinity,
          height: 12,
          borderRadius: 4,
          baseColor: LibraryShimmer._base,
          highlightColor: LibraryShimmer._highlight,
        ),
        SizedBox(height: 5),
        ShimmerBox(
          width: double.infinity,
          height: 10,
          borderRadius: 4,
          baseColor: LibraryShimmer._base,
          highlightColor: LibraryShimmer._highlight,
        ),
        SizedBox(height: 5),
        ShimmerBox(
          width: 72,
          height: 9,
          borderRadius: 4,
          baseColor: LibraryShimmer._base,
          highlightColor: LibraryShimmer._highlight,
        ),
      ],
    );
  }
}

class SearchShimmer extends StatelessWidget {
  const SearchShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 4,
      itemBuilder: (_, __) => const _LegacyBookShimmerCard(),
    );
  }
}

class _LegacyBookShimmerCard extends StatelessWidget {
  const _LegacyBookShimmerCard();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(width: double.infinity, height: 200, borderRadius: 12),
        SizedBox(height: 12),
        ShimmerBox(width: 120, height: 14, borderRadius: 6),
        SizedBox(height: 8),
        ShimmerBox(width: 80, height: 12, borderRadius: 6),
      ],
    );
  }
}

class ReaderShimmer extends StatelessWidget {
  const ReaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: const [
          ShimmerBox(width: double.infinity, height: 48, borderRadius: 12),
          SizedBox(height: 24),
          Expanded(child: ShimmerBox(width: double.infinity, height: double.infinity, borderRadius: 16)),
          SizedBox(height: 16),
          ShimmerBox(width: 100, height: 12, borderRadius: 6),
        ],
      ),
    );
  }
}

class UploadProgressShimmer extends StatelessWidget {
  const UploadProgressShimmer({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.shimmerBase,
              highlightColor: AppColors.shimmerHighlight,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.shimmerBase,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(Icons.cloud_upload_outlined, size: 48, color: AppColors.textMuted),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Uploading your ebook…',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress * 100).toStringAsFixed(0)}% complete',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: AppColors.shimmerBase,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
