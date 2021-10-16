import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteBook {
  final String id;
  final String title;
  final String? image;
  final int? averageRatings;
  final String maturityRating;
  final String? description;
  final List<String>? authors;
  final List<String>? categories;
  final String? publisher;
  final String? publishedDate;

  FavoriteBook({
    required this.id,
    required this.title,
    this.image,
    this.averageRatings,
    required this.maturityRating,
    this.description = 'No Description',
    this.authors,
    this.categories,
    this.publisher,
    this.publishedDate,
  });

  factory FavoriteBook.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      FavoriteBook(
        id: snapshot.id,
        title: snapshot.data()?['title'] as String,
        image: snapshot.data()?['image'] as String,
        averageRatings: snapshot.data()?['averageRatings'] as int,
        maturityRating: snapshot.data()?['averageRatings'] as String,
        authors: snapshot.data()?['authors'] as List<String>,
        categories: snapshot.data()?['categories'] as List<String>,
        publishedDate: snapshot.data()?['publishedDate'] as String,
        publisher: snapshot.data()?['publisher'] as String,
      );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'averageRatings': averageRatings,
      'maturityRating': maturityRating,
      'description': description,
      'authors': authors,
      'categories': categories,
      'publisher': publisher,
      'publishedDate': publishedDate,
    };
  }
}
