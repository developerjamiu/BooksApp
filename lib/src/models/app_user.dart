import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String fullName;
  final String emailAddress;
  final Timestamp timestamp;

  const AppUser({
    required this.id,
    required this.fullName,
    required this.emailAddress,
    required this.timestamp,
  });

  factory AppUser.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      AppUser(
        id: snapshot.id,
        fullName: snapshot.data()?['fullName'] as String,
        emailAddress: snapshot.data()?['emailAddress'] as String,
        timestamp: snapshot.data()?['timestamp'],
      );
}

class UserParams {
  final String fullName;
  final String emailAddress;
  final String? password;

  UserParams({
    required this.fullName,
    required this.emailAddress,
    this.password,
  });

  Map<String, dynamic> toMap() => {
        'fullName': fullName,
        'emailAddress': emailAddress,
        'timestamp': Timestamp.now(),
      };
}
