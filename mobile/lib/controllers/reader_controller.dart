import 'dart:io';

import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/repositories/ebook_repository.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

enum ReaderStatus { loading, ready, error }

class ReaderController extends GetxController {
  ReaderController({EbookRepository? repository})
      : _repository = repository ?? EbookRepository();

  final EbookRepository _repository;
  final pdfViewerController = PdfViewerController();

  late final Ebook ebook;
  final Rx<ReaderStatus> status = ReaderStatus.loading.obs;
  final RxString errorMessage = ''.obs;
  final RxString localFilePath = ''.obs;
  final RxBool isFullScreen = false.obs;
  final RxInt savedPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    ebook = Get.arguments as Ebook;
    _loadSavedPage();
    _loadPdf();
  }

  Future<void> reload() async {
    await _loadPdf();
  }

  Future<void> _loadSavedPage() async {
    final prefs = await SharedPreferences.getInstance();
    savedPage.value = prefs.getInt(_pageKey) ?? 1;
  }

  Future<void> onPageChanged(int page) async {
    savedPage.value = page;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_pageKey, page);
  }

  void toggleFullScreen() {
    isFullScreen.value = !isFullScreen.value;
  }

  String get _pageKey => 'reader_page_${ebook.id}';

  Future<void> _loadPdf() async {
    status.value = ReaderStatus.loading;
    errorMessage.value = '';

    try {
      final bytes = await _repository.downloadEbook(ebook.id);
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/reader_${ebook.id}.pdf';
      final file = File(path);
      await file.writeAsBytes(bytes, flush: true);
      localFilePath.value = path;
      status.value = ReaderStatus.ready;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      status.value = ReaderStatus.error;
    } catch (_) {
      errorMessage.value = 'Unable to open this ebook.';
      status.value = ReaderStatus.error;
    }
  }

  @override
  void onClose() {
    pdfViewerController.dispose();
    super.onClose();
  }
}
