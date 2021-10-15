import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/navigation_service.dart';

class ProfileNotifier extends BaseChangeNotifier {
  ProfileNotifier(this._read);

  final Reader _read;

  User get user => _read(authenticationRepository).currentUser!;

  Future<void> logoutUser() async {
    await _read(authenticationRepository).logout();

    _read(navigationService).navigateOffAllNamed(
      Routes.login,
      (_) => false,
    );
  }
}

final profileNotifierProvider = ChangeNotifierProvider(
  (ref) => ProfileNotifier(ref.read),
);
