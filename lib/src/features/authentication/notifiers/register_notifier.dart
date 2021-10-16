import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';
import '../models/user_params.dart';

class RegisterNotifier extends BaseChangeNotifier {
  RegisterNotifier(this._read);

  final Reader _read;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  Future<void> registerUser({required UserParams userParams}) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepository).register(params: userParams);

      _read(navigationService).navigateOffAllNamed(
        Routes.verifyEmail,
        (_) => false,
      );
    } on Failure catch (ex) {
      _read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }

  /// Register was pushed on to the navigation stack, so here we are just
  /// ...popping it off the stack to return to login
  void navigateToLogin() => _read(navigationService).navigateBack();
}

final registerNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => RegisterNotifier(ref.read),
);
