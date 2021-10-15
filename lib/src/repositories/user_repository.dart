import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/app_user.dart';
import '../services/base/failure.dart';
import 'authentication_repository.dart';

extension FirebaseFirestoreExtension on FirebaseFirestore {
  CollectionReference<Map<String, dynamic>> get userCollection =>
      collection('users');
}

class UserRepository {
  UserRepository({required this.firestore, required this.userId});

  final String? userId;
  final FirebaseFirestore firestore;

  Stream<AppUser> getUser() {
    return firestore.userCollection.doc(userId).snapshots().map(
          (documentSnapshot) => AppUser.fromDocumentSnapshot(
            documentSnapshot,
          ),
        );
  }

  Future<AppUser> getUserFuture() async {
    final user = await firestore.userCollection.doc(userId).get();
    return AppUser.fromDocumentSnapshot(user);
  }

  Future<void> createUser(UserParams user) async {
    try {
      await firestore.userCollection.doc(userId).set(user.toMap());
    } catch (ex) {
      throw Failure('Error creating user');
    }
  }

  Future<void> createUserWithGoogle(UserParams user) async {
    try {
      final snapshot = await firestore.userCollection.doc(userId).get();

      if (!snapshot.exists) {
        await firestore.userCollection.doc(userId).set(user.toMap());
      }
    } catch (ex) {
      throw Failure('Error creating user');
    }
  }

  Future<void> updateEmail(String emailAddress) async {
    try {
      await firestore.userCollection
          .doc(userId)
          .update({'emailAddress': emailAddress});
    } catch (ex) {
      throw Failure('Error updating user email');
    }
  }

  Future<void> updateUser({required String fullName}) async {
    try {
      await firestore.userCollection.doc(userId).update({'fullName': fullName});
    } catch (ex) {
      throw Failure('Error updating user');
    }
  }
}

final userRepository = Provider<UserRepository>(
  (ref) => UserRepository(
    firestore: FirebaseFirestore.instance,
    userId: ref.watch(authenticationRepository).currentUser?.uid,
  ),
);
