import 'package:flutter/material.dart';
import 'package:frontend/controllers/library_controller.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/widgets/book_card.dart';
import 'package:frontend/widgets/delete_confirmation_dialog.dart';
import 'package:frontend/widgets/empty_state_widget.dart';
import 'package:frontend/widgets/error_state_widget.dart';
import 'package:frontend/widgets/loading_widget.dart';
import 'package:get/get.dart';

class LibraryScreen extends GetView<LibraryController> {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ebook Library'),
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: controller.openSearch,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.openUpload,
        icon: const Icon(Icons.upload_file),
        label: const Text('Upload'),
      ),
      body: Obx(() {
        switch (controller.status.value) {
          case LibraryStatus.loading:
            return const LoadingWidget(message: 'Loading your library...');
          case LibraryStatus.error:
            return ErrorStateWidget(
              message: controller.errorMessage.value,
              onRetry: controller.loadEbooks,
            );
          case LibraryStatus.empty:
            return EmptyStateWidget(
              title: 'No books yet',
              message: 'Upload your first PDF to start building your library.',
              actionLabel: 'Upload ebook',
              onAction: controller.openUpload,
            );
          case LibraryStatus.success:
            return RefreshIndicator(
              onRefresh: controller.loadEbooks,
              child: _BookshelfGrid(ebooks: controller.ebooks),
            );
        }
      }),
    );
  }
}

class _BookshelfGrid extends GetView<LibraryController> {
  const _BookshelfGrid({required this.ebooks});

  final List<Ebook> ebooks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      itemCount: _shelfCount(ebooks.length),
      itemBuilder: (context, shelfIndex) {
        final start = shelfIndex * 2;
        final shelfBooks = ebooks.skip(start).take(2).toList();

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Row(
                children: [
                  for (final ebook in shelfBooks)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: SizedBox(
                          height: 280,
                          child: BookCard(
                            ebook: ebook,
                            onTap: () => controller.openReader(ebook),
                            onDownload: () => controller.downloadEbook(ebook),
                            onDelete: () async {
                              final confirmed = await showDeleteConfirmationDialog(
                                context,
                                ebook.title,
                              );
                              if (confirmed == true) {
                                await controller.deleteEbook(ebook);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  if (shelfBooks.length == 1) const Expanded(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFF6D4C41),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _shelfCount(int count) => (count / 2).ceil();
}
