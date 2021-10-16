import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';

class LoginNotifier extends BaseChangeNotifier {
  LoginNotifier(this._read);

  final Reader _read;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    setState();
  }

  Future<void> loginUser({
    required String emailAddress,
    required String password,
  }) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepository).login(
        emailAddress: emailAddress.trim(),
        password: password,
      );

      _read(navigationService).navigateOffNamed(Routes.home);
    } on Failure catch (ex) {
      _read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }

  Future<void> loginUserWithGoogle() async {
    try {
      final user = await _read(authenticationRepository).loginWithGoogle();

      if (user != null) {
        _read(navigationService).navigateOffNamed(Routes.home);
      } else {
        _read(snackbarService).showErrorSnackBar('No email selected');
      }
    } on Failure catch (ex) {
      _read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }

  void navigateToRegister() {
    _read(navigationService).navigateToNamed(Routes.register);
  }
}

final loginNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => LoginNotifier(ref.read),
);
