import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../repositories/user_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';
import '../models/app_user.dart';
import '../providers/user_provider.dart';

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

      final currentUserData = await _read(userRepository).getUser();

      _read(userProvider).state = currentUserData;

      _read(navigationService).navigateOffNamed(Routes.books);
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
        await _read(userRepository).createUserWithGoogle(
          UserParams(
            fullName: user.displayName!,
            emailAddress: user.email!,
          ),
        );

        final currentUserData = await _read(userRepository).getUser();

        _read(userProvider).state = currentUserData;

        _read(navigationService).navigateOffNamed(Routes.books);
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