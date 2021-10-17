import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/books/models/favorite_book.dart';
import 'authentication_repository.dart';

class FavoriteBooksRepository {
  FavoriteBooksRepository({
    required this.authenticationRepository,
    required this.firestore,
  });

  final AuthenticationRepository authenticationRepository;
  final FirebaseFirestore firestore;

  CollectionReference<Map<String, dynamic>> get favoriteBooksCollection =>
      firestore
          .collection("users")
          .doc(authenticationRepository.currentUser!.uid)
          .collection('favorite-books');

  Stream<List<FavoriteBook>> getFavoriteBooks() {
    return favoriteBooksCollection.snapshots().map(
          (querySnapshot) => querySnapshot.docs.map(
            (queryDocumentSnapshot) {
              return FavoriteBook.fromDocumentSnapshot(queryDocumentSnapshot);
            },
          ).toList(),
        );
  }

  Future<bool> bookExists(String bookId) async {
    final snapshot = await favoriteBooksCollection.doc(bookId).get();

    return snapshot.exists;
  }

  Future<void> addBookToFavorite(FavoriteBook book) async {
    return await favoriteBooksCollection.doc(book.id).set(book.toMap());
  }

  Future<void> removeBookFromFavorite(FavoriteBook book) async {
    return await favoriteBooksCollection.doc(book.id).delete();
  }
}

final favoriteBooksRepository = Provider(
  (ref) => FavoriteBooksRepository(
    authenticationRepository: ref.watch(authenticationRepository),
    firestore: FirebaseFirestore.instance,
  ),
);
