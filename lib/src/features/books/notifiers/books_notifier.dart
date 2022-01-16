import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/books_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/snackbar_service.dart';
import '../states/books_state.dart';

class BooksNotitier extends StateNotifier<BooksState> {
  BooksNotitier(this._read) : super(BooksState.initial()) {
    getBooks();
  }

  final Reader _read;

  Future<void> getBooks({String query = AppStrings.defaultBooksQuery}) async {
    try {
      state = state.copyWith(
        viewState: ViewState.loading,
        searchQuery: query,
        currentPage: 1,
      );

      final books = await _read(booksRepository).getBooks(
        currentPage: state.currentPage,
        queryString: query,
      );

      state = state.copyWith(
        books: books,
        currentPage: state.currentPage + 1,
        viewState: ViewState.idle,
      );

      if (state.books!.length < state.pageSize) {
        state = state.copyWith(moreDataAvailable: false);
      }
    } on Failure {
      state = state.copyWith(viewState: ViewState.error);
    }
  }

  Future<void> getMoreBooks() async {
    try {
      final books = await _read(booksRepository).getBooks(
        queryString: state.searchQuery,
        currentPage: state.currentPage,
      );

      if (books.isEmpty) {
        state = state.copyWith(moreDataAvailable: false);
        _read(snackbarService)
            .showErrorSnackBar('You have reached the end of the book list');
      }

      state = state.copyWith(
        books: [...state.books!, ...books],
        viewState: ViewState.idle,
      );
    } on Failure {
      state = state.copyWith(viewState: ViewState.error);
    }
  }
}

final booksNotifierProvider = StateNotifierProvider<BooksNotitier, BooksState>(
  (ref) => BooksNotitier(ref.read),
);
