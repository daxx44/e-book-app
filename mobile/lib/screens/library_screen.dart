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
      floatingActionButton: _AnimatedFab(onPressed: controller.openUpload),
      body: SafeArea(
        child: Builder(
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
          key: ValueKey('success-${controller.ebooks.length}'),
          color: AppColors.accent,
          backgroundColor: AppColors.surface,
          strokeWidth: 2.5,
          displacement: 56,
          onRefresh: controller.loadEbooks,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            itemCount: _shelfCount(controller.ebooks.length),
            itemBuilder: (context, shelfIndex) => _BookshelfRow(
              shelfBooks: _booksOnShelf(controller.ebooks, shelfIndex),
              onOpenDetails: (ebook) => _openDetails(context, ebook),
              onRead: controller.openReader,
              onDownload: controller.downloadEbook,
              onDelete: (ebook) => _confirmDelete(context, ebook),
            ),
          ),
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

  static List<Ebook> _booksOnShelf(List<Ebook> ebooks, int shelfIndex) {
    final start = shelfIndex * 2;
    return ebooks.skip(start).take(2).toList();
  }

  static int _shelfCount(int count) => count == 0 ? 0 : (count / 2).ceil();
}

class _AnimatedFab extends StatefulWidget {
  const _AnimatedFab({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_AnimatedFab> createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<_AnimatedFab> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1, end: 1.04).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut)),
      child: FloatingActionButton.extended(
        onPressed: widget.onPressed,
        elevation: 8,
        highlightElevation: 12,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Book'),
      ),
    );
  }
}

class _BookshelfRow extends StatelessWidget {
  const _BookshelfRow({
    required this.shelfBooks,
    required this.onOpenDetails,
    required this.onRead,
    required this.onDownload,
    required this.onDelete,
  });

  final List<Ebook> shelfBooks;
  final void Function(Ebook) onOpenDetails;
  final void Function(Ebook) onRead;
  final Future<void> Function(Ebook) onDownload;
  final Future<void> Function(Ebook) onDelete;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 600;
    final isLandscape = MediaQuery.orientationOf(context) == Orientation.landscape;
    final booksPerRow = isWide || isLandscape ? 3 : 2;
    final bookHeight = isWide ? 300.0 : (isLandscape ? 240.0 : 268.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final ebook in shelfBooks)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: SizedBox(
                      height: bookHeight,
                      child: TweenAnimationBuilder<double>(
                        key: ValueKey('book-${ebook.id}'),
                        tween: Tween(begin: 0.9, end: 1),
                        duration: const Duration(milliseconds: 450),
                        curve: Curves.easeOutCubic,
                        builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
                        child: BookCard(
                          ebook: ebook,
                          onTap: () => onOpenDetails(ebook),
                          onRead: () => onRead(ebook),
                          onDownload: () => onDownload(ebook),
                          onDelete: () => onDelete(ebook),
                        ),
                      ),
                    ),
                  ),
                ),
              for (var i = shelfBooks.length; i < booksPerRow; i++) const Expanded(child: SizedBox()),
            ],
          ),
          const ShelfDivider(),
        ],
      ),
    );
  }
}
