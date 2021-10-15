import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/utilities/base_change_notifier.dart';
import '../models/book.dart';
import '../repositories/books_repository.dart';
import '../services/base/failure.dart';
import '../services/snackbar_service.dart';

class BooksNotitier extends BaseChangeNotifier {
  BooksNotitier({
    required this.booksRepository,
    required this.snackbarService,
  }) {
    getBooks();
  }

  final BooksRepository booksRepository;
  final SnackbarService snackbarService;

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

      _books = await booksRepository.getBooks(
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
      final books = await booksRepository.getBooks(
        queryString: searchQuery,
        currentPage: _currentPage,
      );

      if (books.isEmpty) {
        _moreDataAvailable = false;
        snackbarService
            .showErrorSnackBar('You have reached the end of the book list');
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
  (ref) => BooksNotitier(
    booksRepository: ref.read(booksRepository),
    snackbarService: ref.read(snackbarServiceProvider),
  ),
);
