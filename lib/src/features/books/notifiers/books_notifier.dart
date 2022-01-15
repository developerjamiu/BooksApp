import 'package:books/src/core/constants/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../models/book.dart';
import '../../../repositories/books_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/snackbar_service.dart';

class BooksNotitier extends BaseChangeNotifier {
  BooksNotitier(this._read) {
    getBooks();
  }

  final Reader _read;

  late List<Book> _books;
  List<Book> get books => _books;

  int _currentPage = 1;
  final int _pageSize = 20;

  bool _moreDataAvailable = true;
  bool get moreDataAvailable => _moreDataAvailable;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Future<void> getBooks({String query = AppStrings.defaultBooksQuery}) async {
    try {
      setState(state: AppState.loading);

      _searchQuery = query;
      _currentPage = 1;

      _books = await _read(booksRepository).getBooks(
        currentPage: _currentPage,
        queryString: query,
      );

      if (_books.length < _pageSize) _moreDataAvailable = false;

      _currentPage++;

      setState(state: AppState.idle);
    } on Failure {
      setState(state: AppState.error);
    } catch (ex) {
      setState(state: AppState.error);
    }
  }

  Future<void> getMoreBooks() async {
    try {
      final books = await _read(booksRepository).getBooks(
        queryString: searchQuery,
        currentPage: _currentPage,
      );

      if (books.isEmpty) {
        _moreDataAvailable = false;
        _read(snackbarService)
            .showErrorSnackBar('You have reached the end of the book list');
      }

      _books.addAll(books);

      setState(state: AppState.idle);
    } on Failure {
      setState(state: AppState.error);
    } catch (ex) {
      setState(state: AppState.error);
    }
  }
}

final booksNotifierProvider = ChangeNotifierProvider(
  (ref) => BooksNotitier(ref.read),
);
