import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 16,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.shimmerBase,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class LibraryShimmer extends StatelessWidget {
  const LibraryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _BookShimmerCard()),
                  const SizedBox(width: 16),
                  Expanded(child: _BookShimmerCard()),
                ],
              ),
              const SizedBox(height: 12),
              const ShimmerBox(width: double.infinity, height: 12, borderRadius: 6),
            ],
          ),
        );
      },
    );
  }
}

class _BookShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ShimmerBox(width: double.infinity, height: 200, borderRadius: 12),
        SizedBox(height: 12),
        ShimmerBox(width: 120, height: 14, borderRadius: 6),
        SizedBox(height: 8),
        ShimmerBox(width: 80, height: 12, borderRadius: 6),
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
      itemBuilder: (_, __) => _BookShimmerCard(),
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
