import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/reader_controller.dart';
import 'package:frontend/widgets/error_state_widget.dart';
import 'package:frontend/widgets/loading_widget.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReaderScreen extends GetView<ReaderController> {
  const ReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.ebook.title)),
      body: Obx(() {
        switch (controller.status.value) {
          case ReaderStatus.loading:
            return const LoadingWidget(message: 'Opening ebook...');
          case ReaderStatus.error:
            return ErrorStateWidget(
              message: controller.errorMessage.value,
              onRetry: controller.reload,
            );
          case ReaderStatus.ready:
            return SfPdfViewer.file(
              File(controller.localFilePath.value),
              canShowScrollHead: true,
              canShowPaginationDialog: true,
            );
        }
      }),
    );
  }
}
