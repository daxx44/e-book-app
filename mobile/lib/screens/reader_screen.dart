import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/controllers/reader_controller.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/widgets/error_state_widget.dart';
import 'package:frontend/widgets/loading_widget.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReaderScreen extends GetView<ReaderController> {
  const ReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final immersive = controller.isFullScreen.value;

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: immersive ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: immersive ? Colors.black : AppColors.background,
          extendBodyBehindAppBar: immersive,
          appBar: immersive
              ? null
              : AppBar(
                  title: Text(
                    controller.ebook.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  actions: [
                    IconButton(
                      tooltip: 'Immersive reading',
                      onPressed: controller.toggleFullScreen,
                      icon: const Icon(Icons.fullscreen_rounded),
                    ),
                  ],
                ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: _buildBody(context, immersive),
          ),
        ),
      );
    });
  }

  Widget _buildBody(BuildContext context, bool immersive) {
    switch (controller.status.value) {
      case ReaderStatus.loading:
        return const LoadingWidget(key: ValueKey('loading'), variant: LoadingVariant.reader);
      case ReaderStatus.error:
        return ErrorStateWidget(
          key: const ValueKey('error'),
          message: controller.errorMessage.value,
          onRetry: controller.reload,
        );
      case ReaderStatus.ready:
        return GestureDetector(
          key: const ValueKey('reader'),
          onTap: immersive ? controller.toggleFullScreen : null,
          child: Stack(
            children: [
              SfPdfViewer.file(
                File(controller.localFilePath.value),
                controller: controller.pdfViewerController,
                canShowScrollHead: !immersive,
                canShowPaginationDialog: true,
                enableDoubleTapZooming: true,
                pageSpacing: 8,
                onDocumentLoaded: (_) {
                  final page = controller.savedPage.value;
                  if (page > 1) controller.pdfViewerController.jumpToPage(page);
                },
                onPageChanged: (details) => controller.onPageChanged(details.newPageNumber),
              ),
              if (immersive)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          IconButton.filled(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black54,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: controller.toggleFullScreen,
                            icon: const Icon(Icons.fullscreen_exit_rounded),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              controller.ebook.title,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (!immersive)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 16,
                  child: Center(
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark.withValues(alpha: 0.88),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Page ${controller.savedPage.value}',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
    }
  }
}
