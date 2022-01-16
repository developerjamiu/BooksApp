import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/authentication_repository.dart';

class StartupNotifier extends StateNotifier<void> {
  StartupNotifier(this._read) : super(null);

  final Reader _read;

  User? get currentUser => _read(authenticationRepository).currentUser;
}

final startupNotifierProvider = StateNotifierProvider<StartupNotifier, void>(
  (ref) => StartupNotifier(ref.read),
);
