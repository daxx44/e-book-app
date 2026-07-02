import 'package:flutter/material.dart';
import 'package:frontend/controllers/search_controller.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/widgets/book_card.dart';
import 'package:frontend/widgets/book_details_sheet.dart';
import 'package:frontend/widgets/delete_confirmation_dialog.dart';
import 'package:frontend/widgets/empty_illustration.dart';
import 'package:frontend/widgets/empty_state_widget.dart';
import 'package:frontend/widgets/error_state_widget.dart';
import 'package:frontend/widgets/library_header.dart';
import 'package:frontend/widgets/loading_widget.dart';
import 'package:frontend/widgets/sort_menu.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const _recentKey = 'recent_searches';
  List<String> _recentSearches = [];

  EbookSearchController get controller => Get.find<EbookSearchController>();

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => _recentSearches = prefs.getStringList(_recentKey) ?? []);
  }

  Future<void> _saveRecentSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    final updated = [trimmed, ..._recentSearches.where((item) => item != trimmed)].take(6).toList();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentKey, updated);
    if (mounted) setState(() => _recentSearches = updated);
  }

  void _onSearchChanged(String value) {
    controller.onQueryChanged(value);
    if (value.trim().isNotEmpty) _saveRecentSearch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: Get.back),
        title: const Text('Search'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: PremiumSearchField(
              controller: controller.searchController,
              onChanged: _onSearchChanged,
              autofocus: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => SortMenu(value: controller.sortBy.value, onChanged: controller.changeSort)),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              final query = controller.searchController.text;
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 320),
                switchInCurve: Curves.easeOut,
                child: _buildResults(context, query),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context, String query) {
    switch (controller.status.value) {
      case SearchStatus.idle:
        return _RecentSearchesView(
          key: const ValueKey('idle'),
          recentSearches: _recentSearches,
          onTap: (term) {
            controller.searchController.text = term;
            controller.search(term);
          },
        );
      case SearchStatus.loading:
        return const LoadingWidget(key: ValueKey('loading'), variant: LoadingVariant.search);
      case SearchStatus.error:
        return ErrorStateWidget(
          key: const ValueKey('error'),
          message: controller.errorMessage.value,
          onRetry: () => controller.search(controller.searchController.text),
        );
      case SearchStatus.empty:
        return EmptyStateWidget(
          key: const ValueKey('empty'),
          title: 'No matching books',
          message: 'Try another title, author, or filename.',
          icon: Icons.search_off_rounded,
          illustration: const EmptyIllustration(icon: Icons.search_off_rounded),
        );
      case SearchStatus.success:
        return GridView.builder(
          key: ValueKey('results-${controller.results.length}'),
          padding: const EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.sizeOf(context).width > 700 ? 3 : 2,
            childAspectRatio: 0.58,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: controller.results.length,
          itemBuilder: (context, index) {
            final ebook = controller.results[index];
            return TweenAnimationBuilder<double>(
              key: ValueKey('result-${ebook.id}'),
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 280 + (index * 40).clamp(0, 200)),
              curve: Curves.easeOutCubic,
              builder: (context, opacity, child) => Opacity(opacity: opacity, child: child),
              child: BookCard(
                ebook: ebook,
                highlightQuery: query,
                onTap: () => showBookDetailsSheet(
                  context,
                  ebook: ebook,
                  onRead: () => controller.openReader(ebook),
                  onDownload: () => controller.downloadEbook(ebook),
                  onDelete: () async {
                    final confirmed = await showDeleteConfirmationDialog(context, ebook.title);
                    if (confirmed == true) await controller.deleteEbook(ebook);
                  },
                ),
                onRead: () => controller.openReader(ebook),
                onDownload: () => controller.downloadEbook(ebook),
                onDelete: () async {
                  final confirmed = await showDeleteConfirmationDialog(context, ebook.title);
                  if (confirmed == true) await controller.deleteEbook(ebook);
                },
              ),
            );
          },
        );
    }
  }
}

class _RecentSearchesView extends StatelessWidget {
  const _RecentSearchesView({
    super.key,
    required this.recentSearches,
    required this.onTap,
  });

  final List<String> recentSearches;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Suggestions', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Fiction', 'Design', 'PDF', 'Guide']
              .map(
                (term) => ActionChip(
                  label: Text(term),
                  onPressed: () => onTap(term),
                  backgroundColor: AppColors.surface,
                  side: BorderSide(color: AppColors.secondary.withValues(alpha: 0.5)),
                ),
              )
              .toList(),
        ),
        if (recentSearches.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text('Recent searches', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ...recentSearches.map(
            (term) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.history_rounded, color: AppColors.textMuted),
              title: Text(term),
              trailing: const Icon(Icons.north_west_rounded, size: 16, color: AppColors.textMuted),
              onTap: () => onTap(term),
            ),
          ),
        ] else ...[
          const SizedBox(height: AppSpacing.xxl),
          const EmptyStateWidget(
            title: 'Search your library',
            message: 'Find books by title, author, or filename.',
            icon: Icons.search_rounded,
          ),
        ],
      ],
    );
  }
}
