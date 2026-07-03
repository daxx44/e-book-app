import 'package:flutter/material.dart';
import 'package:frontend/models/ebook.dart';
import 'package:frontend/widgets/library/shelf_book_card.dart';
import 'package:frontend/widgets/library/wooden_shelf_plank.dart';

class BookshelfRow extends StatelessWidget {
  const BookshelfRow({
    super.key,
    required this.books,
    required this.booksPerRow,
    required this.onOpenDetails,
    required this.onRead,
    required this.onDownload,
    required this.onDelete,
    this.bookHeight = 196,
  });

  final List<Ebook> books;
  final int booksPerRow;
  final void Function(Ebook) onOpenDetails;
  final void Function(Ebook) onRead;
  final void Function(Ebook) onDownload;
  final void Function(Ebook) onDelete;
  final double bookHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final ebook in books)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ShelfBookCard(
                      key: ValueKey('shelf-book-${ebook.id}'),
                      ebook: ebook,
                      height: bookHeight,
                      onTap: () => onOpenDetails(ebook),
                      onRead: () => onRead(ebook),
                      onDownload: () => onDownload(ebook),
                      onDelete: () => onDelete(ebook),
                    ),
                  ),
                ),
              for (var i = books.length; i < booksPerRow; i++)
                const Expanded(child: SizedBox()),
            ],
          ),
        ),
        const WoodenShelfPlank(),
        const SizedBox(height: 20),
      ],
    );
  }
}
