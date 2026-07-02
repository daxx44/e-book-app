import 'dart:async';
import 'dart:io';

import 'package:frontend/core/constants/app_constants.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/repositories/ebook_repository.dart';
import 'package:frontend/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

enum SearchStatus { idle, loading, success, empty, error }

class EbookSearchController extends GetxController {
  EbookSearchController({EbookRepository? repository})
      : _repository = repository ?? EbookRepository();

  final EbookRepository _repository;
  final searchController = TextEditingController();
  Timer? _debounce;

  final Rx<SearchStatus> status = SearchStatus.idle.obs;
  final RxList<Ebook> results = <Ebook>[].obs;
  final RxString errorMessage = ''.obs;

  void onQueryChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(AppConstants.searchDebounce, () => search(value));
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      results.clear();
      status.value = SearchStatus.idle;
      return;
    }

    status.value = SearchStatus.loading;
    errorMessage.value = '';

    try {
      final ebooks = await _repository.searchEbooks(trimmed);
      results.assignAll(ebooks);
      status.value = ebooks.isEmpty ? SearchStatus.empty : SearchStatus.success;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      status.value = SearchStatus.error;
    } catch (_) {
      errorMessage.value = 'Search failed. Please try again.';
      status.value = SearchStatus.error;
    }
  }

  void openReader(Ebook ebook) {
    Get.toNamed(AppRoutes.reader, arguments: ebook);
  }

  Future<void> downloadEbook(Ebook ebook) async {
    try {
      final bytes = await _repository.downloadEbook(ebook.id);
      final directory = await getApplicationDocumentsDirectory();
      final safeName = ebook.filename ?? '${ebook.id}.pdf';
      final savedPath = '${directory.path}/$safeName';
      await File(savedPath).writeAsBytes(bytes, flush: true);
      Get.snackbar('Download complete', 'Saved to $safeName');
      await OpenFilex.open(savedPath);
    } on ApiException catch (error) {
      Get.snackbar('Download failed', error.message);
    }
  }

  Future<void> deleteEbook(Ebook ebook) async {
    try {
      await _repository.deleteEbook(ebook.id);
      results.removeWhere((item) => item.id == ebook.id);
      if (results.isEmpty && searchController.text.trim().isNotEmpty) {
        status.value = SearchStatus.empty;
      }
      Get.snackbar('Deleted', '${ebook.title} was removed.');
    } on ApiException catch (error) {
      Get.snackbar('Delete failed', error.message);
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    searchController.dispose();
    super.onClose();
  }
}
