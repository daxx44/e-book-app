import 'package:flutter/material.dart';
import 'package:frontend/controllers/search_controller.dart';
import 'package:frontend/widgets/book_card.dart';
import 'package:frontend/widgets/delete_confirmation_dialog.dart';
import 'package:frontend/widgets/empty_state_widget.dart';
import 'package:frontend/widgets/error_state_widget.dart';
import 'package:frontend/widgets/loading_widget.dart';
import 'package:get/get.dart';

class SearchScreen extends GetView<EbookSearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller.searchController,
          decoration: const InputDecoration(
            hintText: 'Search by title, author, or filename',
            border: InputBorder.none,
          ),
          onChanged: controller.onQueryChanged,
        ),
      ),
      body: Obx(() {
        switch (controller.status.value) {
          case SearchStatus.idle:
            return const EmptyStateWidget(
              title: 'Search your library',
              message: 'Type a keyword to find ebooks.',
            );
          case SearchStatus.loading:
            return const LoadingWidget(message: 'Searching...');
          case SearchStatus.error:
            return ErrorStateWidget(
              message: controller.errorMessage.value,
              onRetry: () => controller.search(controller.searchController.text),
            );
          case SearchStatus.empty:
            return const EmptyStateWidget(
              title: 'No matching books',
              message: 'Try a different title, author, or filename.',
            );
          case SearchStatus.success:
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.62,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: controller.results.length,
              itemBuilder: (context, index) {
                final ebook = controller.results[index];
                return BookCard(
                  ebook: ebook,
                  onTap: () => controller.openReader(ebook),
                  onDownload: () => controller.downloadEbook(ebook),
                  onDelete: () async {
                    final confirmed = await showDeleteConfirmationDialog(
                      context,
                      ebook.title,
                    );
                    if (confirmed == true) await controller.deleteEbook(ebook);
                  },
                );
              },
            );
        }
      }),
    );
  }
}
