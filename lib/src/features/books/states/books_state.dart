import '../../../core/utilities/view_state.dart';
import '../models/book.dart';

class BooksState {
  final ViewState viewState;
  final List<Book>? books;
  final int currentPage;
  final bool moreDataAvailable;
  final String searchQuery;

  const BooksState._({
    this.books,
    required this.viewState,
    required this.currentPage,
    required this.moreDataAvailable,
    required this.searchQuery,
  });

  factory BooksState.initial() => const BooksState._(
        currentPage: 1,
        moreDataAvailable: true,
        viewState: ViewState.idle,
        searchQuery: '',
      );

  final int pageSize = 20;

  BooksState copyWith({
    List<Book>? books,
    int? currentPage,
    bool? moreDataAvailable,
    String? searchQuery,
    ViewState? viewState,
  }) {
    return BooksState._(
      books: books ?? this.books,
      currentPage: currentPage ?? this.currentPage,
      moreDataAvailable: moreDataAvailable ?? this.moreDataAvailable,
      searchQuery: searchQuery ?? this.searchQuery,
      viewState: viewState ?? this.viewState,
    );
  }
}
