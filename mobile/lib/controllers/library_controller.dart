import 'package:frontend/core/utils/app_feedback.dart';
import 'package:frontend/core/utils/app_haptics.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/repositories/ebook_repository.dart';
import 'package:frontend/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

enum LibraryStatus { loading, success, empty, error }

class LibraryController extends GetxController {
  LibraryController({EbookRepository? repository})
      : _repository = repository ?? EbookRepository();

  final EbookRepository _repository;

  final Rx<LibraryStatus> status = LibraryStatus.loading.obs;
  final RxList<Ebook> ebooks = <Ebook>[].obs;
  final RxString errorMessage = ''.obs;
  final RxBool isDeleting = false.obs;
  final RxBool isDownloading = false.obs;
  final RxString sortBy = 'recent'.obs;

  @override
  void onInit() {
    super.onInit();
    loadEbooks();
  }

  Future<void> loadEbooks() async {
    status.value = LibraryStatus.loading;
    errorMessage.value = '';

    try {
      final results = await _repository.fetchEbooks(sort: sortBy.value);
      ebooks.assignAll(results);
      status.value = results.isEmpty ? LibraryStatus.empty : LibraryStatus.success;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      status.value = LibraryStatus.error;
    } catch (_) {
      errorMessage.value = 'Failed to load library.';
      status.value = LibraryStatus.error;
    }
  }

  Future<void> deleteEbook(Ebook ebook) async {
    isDeleting.value = true;
    try {
      await _repository.deleteEbook(ebook.id);
      ebooks.removeWhere((item) => item.id == ebook.id);
      status.value = ebooks.isEmpty ? LibraryStatus.empty : LibraryStatus.success;
      AppFeedback.success('Removed', message: '${ebook.title} was deleted.');
    } on ApiException catch (error) {
      AppFeedback.error('Delete failed', message: error.message);
    } catch (_) {
      AppFeedback.error('Delete failed', message: 'Please try again.');
    } finally {
      isDeleting.value = false;
    }
  }

  Future<void> downloadEbook(Ebook ebook) async {
    isDownloading.value = true;
    AppHaptics.light();
    try {
      final bytes = await _repository.downloadEbook(ebook.id);
      final directory = await getApplicationDocumentsDirectory();
      final safeName = ebook.filename ?? '${ebook.id}.pdf';
      final savedPath = '${directory.path}/$safeName';
      final file = File(savedPath);
      await file.writeAsBytes(bytes, flush: true);

      AppFeedback.success('Download complete', message: safeName);
      await OpenFilex.open(savedPath);
    } on ApiException catch (error) {
      AppFeedback.error('Download failed', message: error.message);
    } catch (_) {
      AppFeedback.error('Download failed', message: 'Please try again.');
    } finally {
      isDownloading.value = false;
    }
  }

  void changeSort(String value) {
    sortBy.value = value;
    AppHaptics.selection();
    loadEbooks();
  }

  void openReader(Ebook ebook) {
    AppHaptics.medium();
    Get.toNamed(AppRoutes.reader, arguments: ebook);
  }

  void openUpload() {
    AppHaptics.light();
    Get.toNamed(AppRoutes.upload)?.then((_) => loadEbooks());
  }

  void openSearch() {
    AppHaptics.light();
    Get.toNamed(AppRoutes.search)?.then((_) => loadEbooks());
  }
}
