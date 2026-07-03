import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/controllers/library_controller.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/widgets/app_drawer.dart';
import 'package:frontend/widgets/book_card.dart';
import 'package:frontend/widgets/book_details_sheet.dart';
import 'package:frontend/widgets/delete_confirmation_dialog.dart';
import 'package:frontend/widgets/empty_state_widget.dart';
import 'package:frontend/widgets/error_state_widget.dart';
import 'package:frontend/widgets/library_header.dart';
import 'package:frontend/widgets/loading_widget.dart';
import 'package:frontend/widgets/recently_read_section.dart';
import 'package:frontend/widgets/sort_menu.dart';
import 'package:get/get.dart';

class LibraryScreen extends GetView<LibraryController> {
  const LibraryScreen({super.key});

  int _headerBookCount() {
    if (controller.status.value == LibraryStatus.success) {
      return controller.ebooks.length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.openUpload,
        elevation: 3,
        highlightElevation: 6,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add book'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Builder(
        builder: (scaffoldContext) {
          return Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _libraryHeader(scaffoldContext, bookCount: _headerBookCount()),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: _buildBody(scaffoldContext),
                  ),
                ),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _libraryHeader(BuildContext context, {required int bookCount}) {
    return LibraryHeader(
      bookCount: bookCount,
      onSearch: controller.openSearch,
      onFilter: () {},
      onMenu: () => Scaffold.of(context).openDrawer(),
      sortMenu: Obx(
        () => SortMenu(value: controller.sortBy.value, onChanged: controller.changeSort),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (controller.status.value) {
      case LibraryStatus.loading:
        return const LoadingWidget(key: ValueKey('loading'));
      case LibraryStatus.error:
        return ErrorStateWidget(
          key: const ValueKey('error'),
          message: controller.errorMessage.value,
          onRetry: controller.loadEbooks,
        );
      case LibraryStatus.empty:
        return EmptyStateWidget(
          key: const ValueKey('empty'),
          title: 'No books yet',
          message: 'Upload your first ebook to start building your personal library.',
          actionLabel: 'Upload ebook',
          onAction: controller.openUpload,
        );
      case LibraryStatus.success:
        return RefreshIndicator(
          key: ValueKey('success-${controller.ebooks.length}-${controller.recentlyRead.length}'),
          color: AppColors.accent,
          backgroundColor: AppColors.surface,
          strokeWidth: 2.5,
          displacement: 56,
          onRefresh: controller.loadEbooks,
          child: Obx(() {
            final ebooks = controller.ebooks;
            final hasRecent = controller.recentlyRead.isNotEmpty;
            final grid = _gridLayoutFor(context);

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              slivers: [
                SliverToBoxAdapter(
                  child: RecentlyReadSection(
                    items: controller.recentlyRead,
                    ebooksById: controller.ebooksById,
                    onOpen: (ebook) => _openDetails(context, ebook),
                    onContinue: controller.openReader,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _LibrarySectionHeader(
                    title: hasRecent ? 'All Books' : 'Your Books',
                    count: ebooks.length,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, 108),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: grid.crossAxisCount,
                      mainAxisSpacing: grid.mainAxisSpacing,
                      crossAxisSpacing: grid.crossAxisSpacing,
                      childAspectRatio: grid.childAspectRatio,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final ebook = ebooks[index];
                        return BookCard(
                          key: ValueKey('library-book-${ebook.id}'),
                          ebook: ebook,
                          onTap: () => _openDetails(context, ebook),
                          onRead: () => controller.openReader(ebook),
                          onDownload: () => controller.downloadEbook(ebook),
                          onDelete: () => _confirmDelete(context, ebook),
                        );
                      },
                      childCount: ebooks.length,
                    ),
                  ),
                ),
              ],
            );
          }),
        );
    }
  }

  void _openDetails(BuildContext context, Ebook ebook) {
    showBookDetailsSheet(
      context,
      ebook: ebook,
      onRead: () => controller.openReader(ebook),
      onDownload: () => controller.downloadEbook(ebook),
      onDelete: () => _confirmDelete(context, ebook),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Ebook ebook) async {
    final confirmed = await showDeleteConfirmationDialog(context, ebook.title);
    if (confirmed == true) await controller.deleteEbook(ebook);
  }

  static _LibraryGridLayout _gridLayoutFor(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isLandscape = MediaQuery.orientationOf(context) == Orientation.landscape;

    if (width >= 900) {
      return const _LibraryGridLayout(crossAxisCount: 4, childAspectRatio: 0.52);
    }
    if (width >= 600 || isLandscape) {
      return const _LibraryGridLayout(crossAxisCount: 3, childAspectRatio: 0.52);
    }
    return const _LibraryGridLayout(crossAxisCount: 2, childAspectRatio: 0.50);
  }
}

class _LibraryGridLayout {
  const _LibraryGridLayout({
    required this.crossAxisCount,
    required this.childAspectRatio,
  });

  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing = 20;
  final double crossAxisSpacing = 14;
}

class _LibrarySectionHeader extends StatelessWidget {
  const _LibrarySectionHeader({
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm + 4),
      child: Row(
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.surfaceSoft,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.secondary.withValues(alpha: 0.4)),
            ),
            child: Text(
              '$count',
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
