import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_constants.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/core/utils/app_feedback.dart';
import 'package:frontend/core/utils/app_haptics.dart';
import 'package:frontend/repositories/ebook_repository.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  UploadController({EbookRepository? repository})
      : _repository = repository ?? EbookRepository();

  final EbookRepository _repository;
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();

  final RxString selectedFileName = ''.obs;
  final RxString selectedFilePath = ''.obs;
  final RxBool isUploading = false.obs;
  final RxDouble uploadProgress = 0.0.obs;
  final RxString errorMessage = ''.obs;
  final RxBool showSuccess = false.obs;

  String? _pickedFilePath;

  Future<void> pickPdf() async {
    errorMessage.value = '';
    AppHaptics.selection();
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
      withData: false,
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    final path = file.path;
    if (path == null) {
      errorMessage.value = 'Could not read the selected file.';
      AppHaptics.error();
      return;
    }

    if (file.size > AppConstants.maxUploadBytes) {
      errorMessage.value = 'File must be less than 100 MB.';
      AppHaptics.error();
      return;
    }

    _pickedFilePath = path;
    selectedFilePath.value = path;
    selectedFileName.value = file.name;
  }

  /// Returns true when upload succeeds (UI handles navigation + success animation).
  Future<bool> upload() async {
    if (titleController.text.trim().isEmpty) {
      errorMessage.value = 'Title is required.';
      AppHaptics.error();
      return false;
    }

    if (_pickedFilePath == null) {
      errorMessage.value = 'Please select a PDF file.';
      AppHaptics.error();
      return false;
    }

    isUploading.value = true;
    uploadProgress.value = 0;
    errorMessage.value = '';

    try {
      await _repository.uploadEbook(
        title: titleController.text.trim(),
        author: authorController.text.trim(),
        description: descriptionController.text.trim(),
        filePath: _pickedFilePath!,
        fileName: selectedFileName.value,
        onSendProgress: (sent, total) {
          if (total > 0) uploadProgress.value = sent / total;
        },
      );

      showSuccess.value = true;
      AppHaptics.success();
      return true;
    } on ApiException catch (error) {
      errorMessage.value = error.details.isNotEmpty
          ? error.details.map((item) => item.message).join('\n')
          : error.message;
      AppFeedback.error('Upload failed', message: errorMessage.value);
      return false;
    } catch (_) {
      errorMessage.value = 'Upload failed. Please try again.';
      AppFeedback.error('Upload failed', message: errorMessage.value);
      return false;
    } finally {
      isUploading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
