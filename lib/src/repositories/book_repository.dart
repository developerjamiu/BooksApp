import 'package:books/src/services/base/api_data.dart';
import 'package:logging/logging.dart';

import '../models/book.dart';
import '../services/network/i_network_service.dart';

class BookRepository {
  final log = Logger('BookRepository');

  final INetworkService networkService;

  BookRepository({required this.networkService});

  Future<List<Book>> getBooks({
    String queryString = '\'\'',
    int currentPage = 1,
    int pageSize = 20,
  }) async {
    const apiKey = APIData.apiKey;
    final offSet = (currentPage - 1) * pageSize;
    final query =
        'q=$queryString&startIndex=$offSet&maxResults=$pageSize&key=$apiKey';

    final uri = APIData.fetchBooks(
      query: query,
    );

    final response = await networkService.get(uri);

    return BookResponse.fromMap(response).books;
  }
}
