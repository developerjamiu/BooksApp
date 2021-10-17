import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/favorite_books_repository.dart';

final favoriteBooksProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(favoriteBooksRepository).getFavoriteBooks();
});
