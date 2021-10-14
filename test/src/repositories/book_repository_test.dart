import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:books/src/models/book.dart';
import 'package:books/src/repositories/books_repository.dart';
import 'package:books/src/services/base/failure.dart';
import 'package:books/src/services/network/i_network_service.dart';

class MockNetworkService extends Mock implements INetworkService {}

void main() {
  final networkService = MockNetworkService();
  final booksRepository = BooksRepository(networkService: networkService);

  setUp(() {
    registerFallbackValue(Uri.parse('uri'));
  });

  group('Book Repository', () {
    test('Should return books on success', () async {
      when(() => networkService.get(any())).thenAnswer(
        (_) => Future.value({'items': []}),
      );

      final books = await booksRepository.getBooks(queryString: '"');

      expect(books, equals(<Book>[]));
    });

    test('Should throw failure on error', () async {
      when(() => networkService.get(any())).thenThrow(Failure('error'));

      final response = booksRepository.getBooks(queryString: '"');

      expect(response, throwsA(isA<Failure>()));
    });
  });
}
