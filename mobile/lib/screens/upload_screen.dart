import 'package:flutter/material.dart';
import 'package:frontend/controllers/upload_controller.dart';
import 'package:frontend/widgets/loading_widget.dart';
import 'package:get/get.dart';

class UploadScreen extends GetView<UploadController> {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload ebook')),
      body: Obx(() {
        if (controller.isUploading.value) {
          return LoadingWidget(
            message: 'Uploading ${(controller.uploadProgress.value * 100).toStringAsFixed(0)}%',
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: controller.titleController,
                decoration: const InputDecoration(labelText: 'Title *'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.authorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: controller.pickPdf,
                icon: const Icon(Icons.attach_file),
                label: Obx(
                  () => Text(
                    controller.selectedFileName.value.isEmpty
                        ? 'Choose PDF'
                        : controller.selectedFileName.value,
                  ),
                ),
              ),
              if (controller.errorMessage.value.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 24),
              FilledButton(
                onPressed: controller.upload,
                child: const Text('Upload'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
