import 'package:intl/intl.dart';

class Ebook {
  const Ebook({
    required this.id,
    required this.title,
    this.author,
    this.description,
    required this.status,
    this.fileType,
    this.fileSize,
    this.filename,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String? author;
  final String? description;
  final String status;
  final String? fileType;
  final int? fileSize;
  final String? filename;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Ebook.fromJson(Map<String, dynamic> json) {
    return Ebook(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String? ?? 'active',
      fileType: json['file_type'] as String?,
      fileSize: json['file_size'] as int?,
      filename: json['filename'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  String get displayAuthor => author?.isNotEmpty == true ? author! : 'Unknown author';

  String get formattedUploadDate => DateFormat.yMMMd().format(createdAt);

  String get fileTypeLabel {
    if (fileType == 'application/pdf') return 'PDF';
    return fileType ?? 'File';
  }
}
