import 'dart:io';

import 'package:frontend/core/network/api_exception.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/repositories/ebook_repository.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

enum ReaderStatus { loading, ready, error }

class ReaderController extends GetxController {
  ReaderController({EbookRepository? repository})
      : _repository = repository ?? EbookRepository();

  final EbookRepository _repository;

  late final Ebook ebook;
  final Rx<ReaderStatus> status = ReaderStatus.loading.obs;
  final RxString errorMessage = ''.obs;
  final RxString localFilePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ebook = Get.arguments as Ebook;
    _loadPdf();
  }

  Future<void> reload() async {
    await _loadPdf();
  }

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
}
