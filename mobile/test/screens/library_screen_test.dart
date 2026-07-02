import 'package:frontend/controllers/library_controller.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/repositories/ebook_repository.dart';
import 'package:frontend/screens/library_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class FakeEbookRepository extends EbookRepository {
  FakeEbookRepository(this.ebooks);

  final List<Ebook> ebooks;

  @override
  Future<List<Ebook>> fetchEbooks({String sort = 'recent'}) async => ebooks;
}

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(Get.reset);

  testWidgets('LibraryScreen shows empty state when no ebooks', (tester) async {
    Get.put(LibraryController(repository: FakeEbookRepository([])));

    await tester.pumpWidget(const GetMaterialApp(home: LibraryScreen()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('No books yet'), findsOneWidget);
  });

  testWidgets('LibraryScreen shows bookshelf when ebooks exist', (tester) async {
    final ebooks = [
      Ebook(
        id: 1,
        title: 'Book One',
        author: 'Author',
        status: 'active',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      ),
    ];
    Get.put(LibraryController(repository: FakeEbookRepository(ebooks)));

    await tester.pumpWidget(const GetMaterialApp(home: LibraryScreen()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Book One'), findsOneWidget);
    expect(find.text('My Library'), findsOneWidget);
  });
}
