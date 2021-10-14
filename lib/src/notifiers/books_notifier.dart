import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/utilities/base_change_notifier.dart';
import '../models/book.dart';
import '../repositories/books_repository.dart';
import '../services/base/failure.dart';

class BooksNotitier extends BaseChangeNotifier {
  BooksNotitier(this._booksRepository) {
    getBooks();
  }

  final BooksRepository _booksRepository;

  late List<Book> _books;
  List<Book> get books => _books;

  int _currentPage = 1;
  final int _pageSize = 20;

  bool _moreDataAvailable = true;
  bool get moreDataAvailable => _moreDataAvailable;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Future<void> getBooks({String query = '""'}) async {
    try {
      setState(state: AppState.loading);

      _searchQuery = query;
      _currentPage = 1;

      _books = await _booksRepository.getBooks(
        currentPage: _currentPage,
        queryString: query,
      );

      if (_books.length < _pageSize) _moreDataAvailable = false;

      _currentPage++;
    } on Failure {
      setState(state: AppState.error);
    } finally {
      setState(state: AppState.idle);
    }
  }

  Future<void> getMoreBooks() async {
    try {
      final books = await _booksRepository.getBooks(
        queryString: searchQuery,
        currentPage: _currentPage,
      );

      if (books.isEmpty) {
        _moreDataAvailable = false;
        //TODO: Show snackbar here to say 'Max reached'
      }

      _books.addAll(books);
    } on Failure {
      setState(state: AppState.error);
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final booksNotifierProvider = ChangeNotifierProvider(
  (ref) => BooksNotitier(ref.read(booksRepository)),
);
