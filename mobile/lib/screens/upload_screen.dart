import 'package:flutter/material.dart';
import 'package:frontend/controllers/upload_controller.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/utils/app_feedback.dart';
import 'package:frontend/widgets/loading_widget.dart';
import 'package:frontend/widgets/primary_button.dart';
import 'package:frontend/widgets/upload_success_view.dart';
import 'package:get/get.dart';

class UploadScreen extends GetView<UploadController> {
  const UploadScreen({super.key});

  Future<void> _handleUpload() async {
    final success = await controller.upload();
    if (!success) return;

    await Future.delayed(const Duration(milliseconds: 1400));
    if (Get.isRegistered<UploadController>()) {
      AppFeedback.success('Added to library', message: controller.titleController.text.trim());
      Get.back(result: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: Get.back,
        ),
        title: const Text('Add to Library'),
      ),
      body: Obx(() {
        if (controller.showSuccess.value) {
          return UploadSuccessView(title: controller.titleController.text.trim());
        }

        if (controller.isUploading.value) {
          return LoadingWidget(
            variant: LoadingVariant.upload,
            progress: controller.uploadProgress.value,
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(Icons.upload_file_rounded, color: Colors.white, size: 40),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text('Upload a new ebook', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Add PDF files to your personal library with title and author details.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: controller.titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Title', hintText: 'Enter book title'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: controller.authorController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Author', hintText: 'Optional'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: controller.descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description', hintText: 'Optional notes'),
              ),
              const SizedBox(height: AppSpacing.lg),
              Obx(() => _SelectedFileCard(
                    fileName: controller.selectedFileName.value,
                    onPick: controller.pickPdf,
                  )),
              if (controller.errorMessage.value.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Text(
                    controller.errorMessage.value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.error),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              Obx(
                () => PrimaryButton(
                  label: 'Upload to Library',
                  icon: Icons.cloud_upload_outlined,
                  isLoading: controller.isUploading.value,
                  onPressed: controller.isUploading.value ? null : _handleUpload,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _SelectedFileCard extends StatelessWidget {
  const _SelectedFileCard({required this.fileName, required this.onPick});

  final String fileName;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName.isNotEmpty;
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: InkWell(
        onTap: onPick,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.accent),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasFile ? fileName : 'Choose PDF file',
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      hasFile ? 'Tap to change file' : 'PDF up to 100 MB',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
