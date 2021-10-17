import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/favorite_books_repository.dart';
import '../models/favorite_book.dart';

class FavoriteBooksNotitier extends BaseChangeNotifier {
  FavoriteBooksNotitier(this._read, {required this.bookId}) {
    checkIsFavorite(bookId);
  }

  final Reader _read;

  final String bookId;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  Future<void> checkIsFavorite(String bookId) async {
    _isFavorite = await _read(favoriteBooksRepository).bookExists(bookId);
    setState(state: AppState.idle);
  }

  Future<void> addOrRemoveFromFavorite(FavoriteBook book) async {
    if (_isFavorite) {
      await removeBookFromFavorite(book);
    } else {
      await addBookToFavorite(book);
    }
  }

  Future<void> addBookToFavorite(FavoriteBook favoriteBook) async {
    await _read(favoriteBooksRepository).addBookToFavorite(favoriteBook);

    await checkIsFavorite(favoriteBook.id);
  }

  Future<void> removeBookFromFavorite(FavoriteBook favoriteBook) async {
    await _read(favoriteBooksRepository).removeBookFromFavorite(favoriteBook);

    await checkIsFavorite(favoriteBook.id);
  }
}

final favoriteBooksNotifierProvider =
    ChangeNotifierProvider.family<FavoriteBooksNotitier, String>(
  (ref, bookId) => FavoriteBooksNotitier(ref.read, bookId: bookId),
);
