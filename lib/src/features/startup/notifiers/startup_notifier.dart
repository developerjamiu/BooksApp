import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';

class StartupNotifier extends BaseChangeNotifier {
  StartupNotifier(this._read);

  final Reader _read;

  User? get currentUser => _read(authenticationRepository).currentUser;
}

final startupNotifierProvider = ChangeNotifierProvider(
  (ref) => StartupNotifier(ref.read),
);
