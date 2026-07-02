import 'package:frontend/controllers/library_controller.dart';
import 'package:frontend/controllers/reader_controller.dart';
import 'package:frontend/controllers/search_controller.dart';
import 'package:frontend/controllers/upload_controller.dart';
import 'package:frontend/screens/library_screen.dart';
import 'package:frontend/screens/reader_screen.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:frontend/screens/upload_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  static const library = '/';
  static const upload = '/upload';
  static const search = '/search';
  static const reader = '/reader';
}

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.library,
      page: () => const LibraryScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(LibraryController.new);
      }),
    ),
    GetPage(
      name: AppRoutes.upload,
      page: () => const UploadScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(UploadController.new);
      }),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(EbookSearchController.new);
      }),
    ),
    GetPage(
      name: AppRoutes.reader,
      page: () => const ReaderScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(ReaderController.new);
      }),
    ),
  ];
}
