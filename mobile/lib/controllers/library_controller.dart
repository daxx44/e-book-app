import 'package:frontend/core/services/recently_read_service.dart';
import 'package:frontend/core/utils/app_feedback.dart';
import 'package:frontend/core/utils/app_haptics.dart';
import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/models/recent_read_entry.dart';
import 'package:frontend/repositories/ebook_repository.dart';
import 'package:frontend/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

enum LibraryStatus { loading, success, empty, error }

class LibraryController extends GetxController {
  LibraryController({
    EbookRepository? repository,
    RecentlyReadService? recentlyReadService,
  })  : _repository = repository ?? EbookRepository(),
        _recentlyReadService = recentlyReadService ?? RecentlyReadService();

  final EbookRepository _repository;
  final RecentlyReadService _recentlyReadService;

  final Rx<LibraryStatus> status = LibraryStatus.loading.obs;
  final RxList<Ebook> ebooks = <Ebook>[].obs;
  final RxList<RecentReadItem> recentlyRead = <RecentReadItem>[].obs;
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
      await _loadRecentlyRead();
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
      await _recentlyReadService.remove(ebook.id);
      ebooks.removeWhere((item) => item.id == ebook.id);
      recentlyRead.removeWhere((item) => item.ebookId == ebook.id);
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
      final safeName = ebook.filename ?? '${ebook.id}${ebook.fileExtension}';
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
    Get.toNamed(AppRoutes.reader, arguments: ebook)?.then((_) => _loadRecentlyRead());
  }

  Future<void> _loadRecentlyRead() async {
    final entries = await _recentlyReadService.loadAll();
    final libraryIds = ebooks.map((book) => book.id).toSet();
    recentlyRead.assignAll(entries.where((entry) => libraryIds.contains(entry.ebookId)));
  }

  Map<int, Ebook> get ebooksById => {for (final book in ebooks) book.id: book};

  void openUpload() {
    AppHaptics.light();
    Get.toNamed(AppRoutes.upload)?.then((_) => loadEbooks());
  }

  void openSearch() {
    AppHaptics.light();
    Get.toNamed(AppRoutes.search)?.then((_) => loadEbooks());
  }
}
