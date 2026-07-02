import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/models/ebook.dart';

class EbookRepository {
  EbookRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<List<Ebook>> fetchEbooks() async {
    final body = await _apiClient.getJson('/ebooks');
    final data = body['data'] as List<dynamic>? ?? [];
    return data.map((item) => Ebook.fromJson(item as Map<String, dynamic>)).toList();
  }

  Future<Ebook> fetchEbook(int id) async {
    final body = await _apiClient.getJson('/ebooks/$id');
    return Ebook.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<List<Ebook>> searchEbooks(String query) async {
    final body = await _apiClient.getJson('/ebooks/search', query: {'q': query});
    final data = body['data'] as List<dynamic>? ?? [];
    return data.map((item) => Ebook.fromJson(item as Map<String, dynamic>)).toList();
  }

  Future<Ebook> uploadEbook({
    required String title,
    String? author,
    String? description,
    required String filePath,
    String? fileName,
    void Function(int, int)? onSendProgress,
  }) async {
    final formData = FormData.fromMap({
      'title': title,
      if (author != null && author.isNotEmpty) 'author': author,
      if (description != null && description.isNotEmpty) 'description': description,
      'file': await MultipartFile.fromFile(
        filePath,
        filename: fileName ?? 'ebook.pdf',
      ),
    });

    final body = await _apiClient.postMultipart(
      '/ebooks',
      formData: formData,
      onSendProgress: onSendProgress,
    );

    return Ebook.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<void> deleteEbook(int id) async {
    await _apiClient.delete('/ebooks/$id');
  }

  Future<List<int>> downloadEbook(int id) async {
    return _apiClient.downloadBytes('/ebooks/$id/download');
  }
}
