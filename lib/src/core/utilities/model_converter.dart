import '../../features/books/models/book.dart';
import '../../features/books/models/favorite_book.dart';

class ModelConverter {
  static FavoriteBook toFavoriteBook(Book book) {
    FavoriteBook favoriteBook = FavoriteBook(
      id: book.id,
      title: book.volumeInfo.title,
      image: book.volumeInfo.imageLinks?.thumbnail,
      averageRatings: book.volumeInfo.averageRating?.toInt(),
      maturityRating: book.volumeInfo.maturityRating,
      authors: book.volumeInfo.authors,
      categories: book.volumeInfo.categories,
      description: book.volumeInfo.description,
      publishedDate: book.volumeInfo.publishedDate,
      publisher: book.volumeInfo.publisher,
    );
    return favoriteBook;
  }
}
