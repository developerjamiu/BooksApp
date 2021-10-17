import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';

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

  Future<void> deleteUser() async {
    try {
      setState(state: AppState.loading);

      final message = await _read(authenticationRepository).deleteUser();

      _read(navigationService).navigateOffAllNamed(
        Routes.login,
        (_) => false,
      );

      _read(snackbarService).showSuccessSnackBar(message);
    } on Failure catch (f) {
      _read(snackbarService).showErrorSnackBar(f.message);
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final profileNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => ProfileNotifier(ref.read),
);
