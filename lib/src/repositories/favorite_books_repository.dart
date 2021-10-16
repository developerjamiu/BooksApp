import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/books/models/favorite_book.dart';
import 'authentication_repository.dart';

class FavoriteBooksRepository {
  FavoriteBooksRepository({
    required this.userId,
    required this.firestore,
  });

  final String userId;
  final FirebaseFirestore firestore;

  Stream<List<FavoriteBook>> getFavoriteBooks() {
    final col = firestore.collection('favorite-books');

    return col.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (queryDocumentSnapshot) =>
                    FavoriteBook.fromDocumentSnapshot(queryDocumentSnapshot),
              )
              .toList(),
        );
  }

  Future<bool> bookExists(String bookId) async {
    final col = firestore.collection('favorite-books');

    final snapshot = await col.doc(bookId).get();

    return snapshot.exists;
  }

  Future<void> addBookToFavorite(FavoriteBook book) async {
    final col = firestore.collection('favorite-books');

    return await col.doc(book.id).set({
      'userId': userId,
      ...book.toMap(),
    });
  }

  Future<void> removeBookFromFavorite(FavoriteBook book) async {
    final col = firestore.collection('favorite-books');

    return await col.doc(book.id).delete();
  }
}

final favoriteBooksRepository = Provider(
  (ref) => FavoriteBooksRepository(
    userId: ref.watch(authenticationRepository).currentUser!.uid,
    firestore: FirebaseFirestore.instance,
  ),
);
