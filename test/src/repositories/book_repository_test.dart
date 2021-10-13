import 'package:books/src/models/book.dart';
import 'package:books/src/repositories/book_repository.dart';

import 'package:books/src/services/network/i_network_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNetworkService extends Mock implements INetworkService {
  @override
  Future get(Uri uri) async {
    return {'items': []};
  }
}

void main() {
  final networkService = MockNetworkService();
  final bookRepository = BookRepository(networkService: networkService);

  group('Book Repository', () {
    test('Should return books on success', () async {
      final books = await bookRepository.getBooks();

      expect(books, <Book>[]);
    });
  });
}
